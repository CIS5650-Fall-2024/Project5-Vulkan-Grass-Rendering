#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

struct GrassBlade {
    vec4 v0;
    vec4 v1;
    vec4 v2;
    vec4 up;
}

// TODO: Declare tessellation control shader inputs and outputs

layout(location = 0) in GrassBlade grassBladeIn;
layout(location = 0) out GrassBlade grassBladeOut;

void main() {

    grassBladeOut = grassBladeIn;

	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs

	// TODO: Set level of tesselation aka how many new vertices to generate
    gl_TessLevelInner[0] = 5.0
    gl_TessLevelInner[1] = 5.0
    gl_TessLevelOuter[0] = 5.0
    gl_TessLevelOuter[1] = 5.0
    gl_TessLevelOuter[2] = 5.0
    gl_TessLevelOuter[3] = 5.0
}
