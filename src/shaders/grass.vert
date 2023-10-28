
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 inV0;
layout(location = 1) in vec4 inV1;
layout(location = 2) in vec4 inV2;

layout(location = 0) out vec4 tcV0;
layout(location = 1) out vec4 tcV1;
layout(location = 2) out vec4 tcV2;

void main() {
	// TODO: Write gl_Position and any other shader outputs
    tcV0 = model * inV0;
    tcV1 = model * inV1;
    tcV2 = model * inV2;
}
