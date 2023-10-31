#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO[DONE?]: Declare tessellation control shader inputs and outputs
in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

layout(location = 0)in vec4 tescv0[];
layout(location = 1)in vec4 tescv1[];
layout(location = 2)in vec4 tescv2[];
layout(location = 3)in vec4 tescup[];

layout(location = 0)out vec4 tesev0[];
layout(location = 1)out vec4 tesev1[];
layout(location = 2)out vec4 tesev2[];
layout(location = 3)out vec4 teseup[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO[DONE?]: Write any shader outputs
    tesev0[gl_InvocationID] = tescv0[gl_InvocationID];
    tesev1[gl_InvocationID] = tescv1[gl_InvocationID];
    tesev2[gl_InvocationID] = tescv2[gl_InvocationID];
    teseup[gl_InvocationID] = tescup[gl_InvocationID];

	// TODO[DONE?]: Set level of tesselation
    int tesselationLevel = 8;
    gl_TessLevelInner[0] = tesselationLevel;
    gl_TessLevelInner[1] = tesselationLevel;
    gl_TessLevelOuter[0] = tesselationLevel;
    gl_TessLevelOuter[1] = tesselationLevel;
    gl_TessLevelOuter[2] = tesselationLevel;
    gl_TessLevelOuter[3] = tesselationLevel;
}
