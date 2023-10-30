
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// DONE: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 inV0;
layout(location = 1) in vec4 inV1;
layout(location = 2) in vec4 inV2;

layout(location = 0) out vec4 outV0;
layout(location = 1) out vec4 outV1;
layout(location = 2) out vec4 outV2;

void main() {
	// DONE: Write gl_Position and any other shader outputs
    gl_Position = model * vec4(inV0.xyz, 1.0);
    outV0 = model * inV0;
    outV1 = model * inV1;
    outV2 = model * inV2;
}
