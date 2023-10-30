
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Declare vertex shader inputs and outputs
layout(location = 0) in vec4 in_v0;
layout(location = 1) in vec4 in_v1;
layout(location = 2) in vec4 in_v2;
layout(location = 3) in vec4 in_up;

layout(location = 0) out vec4 out_v0;
layout(location = 1) out vec4 out_v1;
layout(location = 2) out vec4 out_v2;
layout(location = 3) out vec4 out_up;


void main() {
	// Write gl_Position and any other shader outputs
    vec4 tv0 = model * vec4(in_v0.xyz, 1.f);
    vec4 tv1 = model * vec4(in_v1.xyz, 1.f);
    vec4 tv2 = model * vec4(in_v2.xyz, 1.f);
    vec4 tup = model * vec4(in_up.xyz, 0.f);

    out_v0 = vec4(tv0.xyz/tv0.w, in_v0.w);
    out_v1 = vec4(tv1.xyz/tv1.w, in_v1.w);
    out_v2 = vec4(tv2.xyz/tv2.w, in_v2.w);
    out_up = vec4(tup.xyz, in_up.w);

    gl_Position = model * vec4(in_v0.xyz, 1.f);
}
