
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Declare vertex shader inputs and outputs
layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 v0_tesc;
layout(location = 1) out vec4 v1_tesc;
layout(location = 2) out vec4 v2_tesc;
layout(location = 3) out vec4 up_tesc;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    v0_tesc = model * v0;
    v1_tesc = model * v1;
    v2_tesc = model * v2;
    up_tesc = up;

    gl_Position = model * vec4(v0.xyz, 1.0f);
}
