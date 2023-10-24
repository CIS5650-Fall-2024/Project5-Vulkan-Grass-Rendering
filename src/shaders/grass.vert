#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout(location = 0) in vec4 vs_v0; // w = orientation
layout(location = 1) in vec4 vs_v1; // w = height
layout(location = 2) in vec4 vs_v2; // w = width
layout(location = 3) in vec4 vs_up; // w = stiffness coefficient

layout(location = 0) out vec4 tcs_v1;
layout(location = 1) out vec4 tcs_v2;
layout(location = 2) out vec4 tcs_up;

out gl_PerVertex {
    vec4 gl_Position;
};

vec4 multiplyMatPos(mat4 mat, vec4 v) {
    vec4 vFinal = mat * vec4(v.xyz, 1.f);
    return vec4(vFinal.xyz / vFinal.w, v.w);
}

vec4 multiplyMatDir(mat4 mat, vec4 v) {
    vec4 vFinal = mat * vec4(v.xyz, 0.f);
    return vec4(vFinal.xyz, v.w);
}

void main() {
    gl_Position = multiplyMatPos(model, vs_v0);
    tcs_v1 = multiplyMatPos(model, vs_v1);
    tcs_v2 = multiplyMatPos(model, vs_v2);
    tcs_up = multiplyMatDir(model, vs_up);
}
