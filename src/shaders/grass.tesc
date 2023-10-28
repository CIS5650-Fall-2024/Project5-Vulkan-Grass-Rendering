#version 450
#extension GL_ARB_separate_shader_objects : enable

// Tessellation Control Shader
// https://www.khronos.org/opengl/wiki/Tessellation#Tessellation_primitive_generation

layout(vertices = 1) out; // only want tessellation points to be generated for each blade once
                          // layout vertices = 1 denotes #blades in output patch, NOT #vertices per patch

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4[] in_V0; 
layout(location = 1) in vec4[] in_V1;
layout(location = 2) in vec4[] in_V2;
layout(location = 3) in vec4[] in_Up;

layout(location = 0) out vec4[] out_V0;
layout(location = 1) out vec4[] out_V1;
layout(location = 2) out vec4[] out_V2;
layout(location = 3) out vec4[] out_Up;

#define TESS_LEVEL_INNER 8
#define TESS_LEVEL_OUTER 8

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// Write any shader outputs
    out_V0[gl_InvocationID] = in_V0[gl_InvocationID];
    out_V1[gl_InvocationID] = in_V1[gl_InvocationID];
    out_V2[gl_InvocationID] = in_V2[gl_InvocationID];
    out_Up[gl_InvocationID] = in_Up[gl_InvocationID];

	// Set level of tesselation
    gl_TessLevelInner[0] = TESS_LEVEL_INNER;
    gl_TessLevelInner[1] = TESS_LEVEL_INNER;
    gl_TessLevelOuter[0] = TESS_LEVEL_OUTER;
    gl_TessLevelOuter[1] = TESS_LEVEL_OUTER;
    gl_TessLevelOuter[2] = TESS_LEVEL_OUTER;
    gl_TessLevelOuter[3] = TESS_LEVEL_OUTER;
}
