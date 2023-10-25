#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

in gl_PerVertex {
    vec4 gl_Position;
}gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
}gl_out[];

layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

layout(location = 0) out vec4 out_v1[];
layout(location = 1) out vec4 out_v2[];
layout(location = 2) out vec4 out_up[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;


    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

	// TODO: Write any shader outputs

	// TODO: Set level of tesselation

    gl_TessLevelInner[0] = 2;
    gl_TessLevelInner[1] = 2;

    gl_TessLevelOuter[0] = 4;
    gl_TessLevelOuter[1] = 4;
    gl_TessLevelOuter[2] = 4;
    gl_TessLevelOuter[3] = 4;
    
}
