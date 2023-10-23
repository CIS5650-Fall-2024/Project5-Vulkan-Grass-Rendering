#version 450
#extension GL_ARB_separate_shader_objects : enable

#define LAMBERT 0

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec3 fs_pos;
layout(location = 1) in vec3 fs_nor;
layout(location = 2) in vec2 fs_uv;

layout(location = 0) out vec4 outColor;

const vec3 grassAlbedoOuter = vec3(0.10156, 0.45279, 0.07592);
const vec3 grassAlbedoInner = vec3(0.22784, 0.57081, 0.04568);

const vec3 lightDir = normalize(vec3(3, 2, 1));

void main() {
    vec3 grassAlbedo = mix(grassAlbedoInner, grassAlbedoOuter, abs(fs_uv.x - 0.5) * 2);
    grassAlbedo *= mix(0.5, 1.0, smoothstep(-0.1, 0.6, fs_uv.y));

#if LAMBERT
    float lambert = max(0.2, abs(dot(lightDir, normalize(fs_nor))));
    vec3 finalColor = grassAlbedo * lambert;
#else
    vec3 finalColor = grassAlbedo;
#endif

    outColor = vec4(finalColor, 1.f);
}