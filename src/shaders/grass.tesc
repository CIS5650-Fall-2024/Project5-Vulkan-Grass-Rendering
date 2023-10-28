#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;


layout(location = 0) in vec4 blade_v0[];
layout(location = 1) in vec4 blade_v1[];
layout(location = 2) in vec4 blade_v2[];
layout(location = 3) in vec4 blade_up[];

layout(location = 0) out vec4 blade_v0_out[];
layout(location = 1) out vec4 blade_v1_out[];
layout(location = 2) out vec4 blade_v2_out[];
layout(location = 3) out vec4 blade_up_out[];

in gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
} gl_in[];


void main() {

	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    // Pass the grass blade data through
    blade_v0_out[gl_InvocationID] = blade_v0[gl_InvocationID];
    blade_v1_out[gl_InvocationID] = blade_v1[gl_InvocationID];
    blade_v2_out[gl_InvocationID] = blade_v2[gl_InvocationID];
    blade_up_out[gl_InvocationID] = blade_up[gl_InvocationID];

    gl_TessLevelInner[0] = 5;
    gl_TessLevelInner[1] = 5;
    gl_TessLevelOuter[0] = 5;
    gl_TessLevelOuter[1] = 5;
    gl_TessLevelOuter[2] = 5;
    gl_TessLevelOuter[3] = 5;
}
