#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 v0_i[];
layout(location = 1) in vec4 v1_i[];
layout(location = 2) in vec4 v2_i[];
layout(location = 3) in vec4 up_i[];

layout(location = 0) out vec4 v0_o[];
layout(location = 1) out vec4 v1_o[];
layout(location = 2) out vec4 v2_o[];
layout(location = 3) out vec4 up_o[];


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    v0_o[gl_InvocationID] = v0_i[gl_InvocationID];
    v1_o[gl_InvocationID] = v1_i[gl_InvocationID];
    v2_o[gl_InvocationID] = v2_i[gl_InvocationID];
    up_o[gl_InvocationID] = up_i[gl_InvocationID];

    float level = 8.f;

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;
}
