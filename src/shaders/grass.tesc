#version 450
#extension GL_ARB_separate_shader_objects : enable
#define level 10

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location=0) in vec4 v0[];
layout(location=1) in vec4 v1[];
layout(location=2) in vec4 v2[];
layout(location=3) in vec4 v3[];

layout(location=0) out vec4 outv0[];
layout(location=1) out vec4 outv1[];
layout(location=2) out vec4 outv2[];
layout(location=3) out vec4 outv3[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    outv0[gl_InvocationID]=v0[gl_InvocationID];
    outv1[gl_InvocationID]=v1[gl_InvocationID];
    outv2[gl_InvocationID]=v2[gl_InvocationID];
    outv3[gl_InvocationID]=v3[gl_InvocationID];

	// TODO: Set level of tesselation
    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;
}
