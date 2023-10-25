#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

in gl_PerVertex {
    vec4 gl_Position;
}gl_in[];


layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

layout(location = 0) out vec3 normal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec4 v0 = gl_in[0].gl_Position;
    vec4 v1 = in_v1[0];
    vec4 v2 = in_v2[0];
    vec4 up = in_up[0];

    vec3 forward = vec3(0, 0, 1);
    vec3 right = cross(up.xyz, forward);
    vec3 pos_x = v0.xyz + right * (u - 0.5f) * v2.w;
    vec3 pos = pos_x * (1 - v) + v2.xyz * v;
    //p += normal;
    gl_Position = camera.proj * camera.view * vec4(pos, 1);
    normal = forward;
}
