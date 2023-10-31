
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO[DONE?]: Declare vertex shader inputs and outputs

layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 tescv0;
layout(location = 1) out vec4 tescv1;
layout(location = 2) out vec4 tescv2;
layout(location = 3) out vec4 tescup;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO[DONE?]: Write gl_Position and any other shader outputs
    tescv0 = model * v0;
    tescv1 = model * v1;
    tescv2 = model * v2;
    tescup = up;
    gl_Position = tescv0;
}
