#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Tessellation control shader
layout(location = 0) in vec4 tcs_v0[];
layout(location = 1) in vec4 tcs_v1[];
layout(location = 2) in vec4 tcs_v2[];
layout(location = 3) in vec4 tcs_up[];

// Outputs to the tessellation evaluation shader.
layout(location = 0) out vec4 tes_v0[];
layout(location = 1) out vec4 tes_v1[];
layout(location = 2) out vec4 tes_v2[];
layout(location = 3) out vec4 tes_up[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	//Write any shader outputs
    tes_v0[gl_InvocationID] = tcs_v0[gl_InvocationID];
    tes_v1[gl_InvocationID] = tcs_v1[gl_InvocationID];
    tes_v2[gl_InvocationID] = tcs_v2[gl_InvocationID];
    tes_up[gl_InvocationID] = tcs_up[gl_InvocationID];

	//Set level of tesselation

    int level = 7;
    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;
}
