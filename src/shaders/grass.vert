
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location = 0) in vec4 vs_v0; // v0.w = orientation
layout(location = 1) in vec4 vs_v1; // v1.w = height
layout(location = 2) in vec4 vs_v2; // v2.w = width
layout(location = 3) in vec4 vs_up; // up.w = stiffness coeff

layout(location = 0) out vec4 tcs_v1;
layout(location = 1) out vec4 tcs_v2;
layout(location = 2) out vec4 tcs_up;

out gl_PerVertex {
    vec4 gl_Position;
};

vec4 modelToWorldPos(mat4 mat, vec4 v) {
    vec4 vW = mat * vec4(v.xyz, 1.f);
    return vec4(vW.xyz / vW.w, v.w);
}

vec4 modelToWorldDir(mat4 mat, vec4 v) {
    vec4 vW = mat * vec4(v.xyz, 0.f);
    return vec4(vW.xyz, v.w);
}

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = modelToWorldPos(model, vs_v0);
    tcs_v1 = modelToWorldPos(model, vs_v1);
    tcs_v2 = modelToWorldPos(model, vs_v2);
    tcs_up = modelToWorldDir(model, vs_up);
}
