#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out float h;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float width = in_v2[0].w;
    h = v;

    vec3 v0 = in_v0[0].xyz;
    vec3 v1 = in_v1[0].xyz;
    vec3 v2 = in_v2[0].xyz;
    vec3 up = in_up[0].xyz;
    vec3 t1 = normalize(vec3(sin(in_v0[0].w), 0.0, cos(in_v0[0].w)));

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    vec3 t0 = normalize(b - a);

    // triangles
    float t = u + 0.5 * v - u * v;
    vec3 pos = mix(c0, c1, t);
    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);
}
