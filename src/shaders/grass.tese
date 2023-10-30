#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec4 blade_v0[];
layout(location = 1) in vec4 blade_v1[];
layout(location = 2) in vec4 blade_v2[];
layout(location = 3) in vec4 blade_up[];

layout(location = 0) out vec3 grassNormal;
layout(location = 1) out vec3 grassPosition;

void main() {

    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    float orientation = blade_v0[0].w;
    float height = blade_v1[0].w;
    float width = blade_v2[0].w;

    vec3 v0 = blade_v0[0].xyz;
    vec3 v1 = blade_v1[0].xyz;
    vec3 v2 = blade_v2[0].xyz;
    vec3 up = blade_up[0].xyz;

    vec3 t1 = normalize(vec3(sin(orientation), 0.0, cos(orientation)));

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    vec3 t0 = normalize(b - a); 
    vec3 normal = normalize(cross(t0, t1));

    float t = u + 0.5 * v - u * v;

    vec3 position = mix(c0, c1, t);

    grassPosition = position;
    grassNormal = normal;

    gl_Position = camera.proj * camera.view * vec4(position, 1.0);

}
