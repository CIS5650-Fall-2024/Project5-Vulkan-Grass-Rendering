#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_in[];
layout(location = 1) in vec4 v1_in[];
layout(location = 2) in vec4 v2_in[];

layout(location = 0) out vec3 pos_out;
layout(location = 1) out vec3 nor_out;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = v0_in[0].xyz;
    vec3 v1 = v1_in[0].xyz;
    vec3 v2 = v2_in[0].xyz;

    float direction = v0_in[0].w;
    vec3 t1 = normalize(vec3(cos(direction), 0.0f, sin(direction)));
    float w  = v2_in[0].w;

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;
    vec3 t0 = normalize(b - a);
    vec3 n = normalize(cross(t0, t1));

    float t = u + 0.5 * v - u * v;
    vec3 p = (1 - t) * c0 + t * c1;

    nor_out  = n;
    pos_out  = p;

    gl_Position = camera.proj * camera.view * vec4(p, 1.0);
}
