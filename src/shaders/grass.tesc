#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 4) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout (location = 0) in vec3 v0in[];
layout (location = 1) in vec3 v1in[];
layout (location = 2) in vec3 v2in[];
layout (location = 3) in vec3 upin[];
layout (location = 4) in float win[];

layout (location = 0) out vec3 v0out[];
layout (location = 1) out vec3 v1out[];
layout (location = 2) out vec3 v2out[];
layout (location = 3) out vec3 upout[];
layout (location = 4) out float wout[];


void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    v0out[gl_InvocationID] = v0in[gl_InvocationID];
    v1out[gl_InvocationID] = v1in[gl_InvocationID];
    v2out[gl_InvocationID] = v2in[gl_InvocationID];
    upout[gl_InvocationID] = upin[gl_InvocationID];
    wout[gl_InvocationID] = win[gl_InvocationID];

	// TODO: Set level of tesselation
    float depth = length(v0in[gl_InvocationID].xyz - inverse(camera.view)[3].xyz);


    float level = 4.0;

    if (depth < 2.0)
        level = 32;
    else if (depth < 4.0)
        level = 24;
    else if (depth < 6.0)
        level = 20;
    else if (depth < 8.0)
        level = 16;
    else if (depth < 12.0)
        level = 14;
    else if (depth < 16.0)
        level = 12;
    else if (depth < 20.0)
        level = 10;
    else if (depth < 24.0)
        level = 8;
    else if (depth < 28.0)
        level = 6;
    else if (depth < 32.0)
        level = 4;
    else
        level = 2;


    gl_TessLevelInner[0] = level;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = level;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = level;
}
