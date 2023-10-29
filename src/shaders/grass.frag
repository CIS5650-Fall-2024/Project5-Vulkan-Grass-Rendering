#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec4 fs_pos;
layout(location = 1) in vec4 fs_nor;
layout(location = 2) in vec2 fs_UV;

layout(location = 0) out vec4 outColor;

const vec3 lightPos = vec3(10, 50, 10);

void main() {
    vec3 lightDir = normalize(fs_pos.xyz - lightPos);
    float diffuseTerm = clamp(dot(lightDir, fs_nor.xyz), 0, 1);

    float ambientTerm = 0.2;
    float lightIntensity = diffuseTerm + ambientTerm;

    outColor = vec4(0.0, lightIntensity, 0.0, 1.0);
}
