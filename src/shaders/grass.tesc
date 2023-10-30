#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in vec4[] v0;
layout(location = 1) in vec4[] v1;
layout(location = 2) in vec4[] v2;
layout(location = 3) in vec4[] up;


layout(location = 0) out vec4[] outV0;
layout(location = 1) out vec4[] outV1;
layout(location = 2) out vec4[] outV2;
layout(location = 3) out vec4[] outUp;




void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = 1;
    gl_TessLevelInner[1] = 1;
    gl_TessLevelOuter[0] = 6;
    gl_TessLevelOuter[1] = 1;
    gl_TessLevelOuter[2] = 6;
    gl_TessLevelOuter[3] = 1;

    outV0[gl_InvocationID] = v0[gl_InvocationID];
    outV1[gl_InvocationID] = v1[gl_InvocationID];
    outV2[gl_InvocationID] = v2[gl_InvocationID];
    outUp[gl_InvocationID] = up[gl_InvocationID];
}
