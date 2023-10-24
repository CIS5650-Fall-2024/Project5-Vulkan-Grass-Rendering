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

layout(location = 0) out vec3 position;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

    vec3 p0 = in_v0[0].xyz;
    vec3 p1 = in_v1[0].xyz;
    vec3 p2 = in_v2[0].xyz;

    float direction = in_v0[0].w;
    //float height = in_v1[0].w;
    float width = in_v2[0].w;
    //float stiffness = in_up[0].w;

    vec3 p00 = mix(p0, p1, v);
    vec3 p01 = mix(p1, p2, v);
    vec3 p10 = mix(p00, p01, v);

    vec3 dir_vec = vec3(cos(direction), 0, sin(direction));

    vec3 p = mix(p10 - width * dir_vec, p10 + width * dir_vec, u);

    gl_Position = camera.proj * camera.view * vec4(p, 1.f);
}
