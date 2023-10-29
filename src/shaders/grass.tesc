#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// https://ogldev.org/www/tutorial30/tutorial30.html - consider TESS_LVL based on cam dist
layout(location = 0) in vec4[] in_v0; // just 1 element per arr
layout(location = 1) in vec4[] in_v1;
layout(location = 2) in vec4[] in_v2;
layout(location = 3) in vec4[] in_up;

layout(location = 0) out vec4[] out_v0;
layout(location = 1) out vec4[] out_v1;
layout(location = 2) out vec4[] out_v2;
layout(location = 3) out vec4[] out_up;

#define TESS_LVL_INNER 5
#define TESS_LVL_OUTER 5

void main() {
	// Don't move the origin location of the patch
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

    gl_TessLevelInner[0] = TESS_LVL_INNER;
    gl_TessLevelInner[1] = TESS_LVL_INNER;
    gl_TessLevelOuter[0] = TESS_LVL_OUTER;
    gl_TessLevelOuter[1] = TESS_LVL_OUTER;
    gl_TessLevelOuter[2] = TESS_LVL_OUTER;
    gl_TessLevelOuter[3] = TESS_LVL_OUTER;
}
