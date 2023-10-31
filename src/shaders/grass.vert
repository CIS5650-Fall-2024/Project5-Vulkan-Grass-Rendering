
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout (location = 0) in vec4 v0;
layout (location = 1) in vec4 v1;
layout (location = 2) in vec4 v2;
layout (location = 3) in vec4 up;

layout (location = 0) out vec3 v0out;
layout (location = 1) out vec3 v1out;
layout (location = 2) out vec3 v2out;
layout (location = 3) out vec3 upout;
layout (location = 4) out float wout;


void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = model * v0;
    v0out = vec3(model * vec4(vec3(v0), 1.0));
    v1out = vec3(model * vec4(vec3(v1), 1.0));
    v2out = vec3(model * vec4(vec3(v2), 1.0));
    wout = v2.w;
    upout = normalize(vec3(wout * cos(v0.w), 0.0, wout * sin(v0.w))); 
}
