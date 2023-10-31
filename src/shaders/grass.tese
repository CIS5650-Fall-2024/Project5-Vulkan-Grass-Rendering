#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec3 v0in[];
layout (location = 1) in vec3 v1in[];
layout (location = 2) in vec3 v2in[];
layout (location = 3) in vec3 upin[];
layout (location = 4) in float win[];

layout (location = 0) out vec3 normal;
layout (location = 1) out float heightFraction;

void main() {
    float u = gl_TessCoord.x * 1.5;
    float v = gl_TessCoord.y;

    vec3 v0 = v0in[0];
    vec3 v1 = v1in[0];
    vec3 v2 = v2in[0];
    vec3 t1 = upin[0];
    float width = win[0];

    // Computing blade positions using u and v
    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    float t = u + 0.5 * v - u * v;
    vec3 position = mix(c0, c1, t);

    gl_Position = camera.proj * camera.view * vec4(position, 1.0);

    vec3 t0 = normalize(b - a);
    normal = normalize(cross(t0, t1));

    heightFraction = v;
}
