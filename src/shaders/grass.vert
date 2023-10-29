
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout(location = 0) in vec4 in_v0;
layout(location = 1) in vec4 in_v1;
layout(location = 2) in vec4 in_v2;
layout(location = 3) in vec4 in_up;

layout(location = 0) out vec4 out_v0;
layout(location = 1) out vec4 out_v1;
layout(location = 2) out vec4 out_v2;
layout(location = 3) out vec4 out_up;

void main() {
    out_v0 = vec4((model * vec4(in_v0.xyz, 1.f)).xyz, in_v0.w);
    out_v1 = vec4((model * vec4(in_v1.xyz, 1.f)).xyz, in_v1.w);
    out_v2 = vec4((model * vec4(in_v2.xyz, 1.f)).xyz, in_v2.w);
    out_up = vec4((model * vec4(in_up.xyz, 1.f)).xyz, in_up.w);
}
