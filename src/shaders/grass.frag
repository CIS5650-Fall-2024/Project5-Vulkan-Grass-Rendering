#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec3 fs_pos;
layout(location = 1) in vec3 fs_nor;
layout(location = 2) in vec2 fs_uv;

layout(location = 0) out vec4 outColor;

const vec3 grassAlbedoOuter = vec3(0.0745, 0.4275, 0.0824);
const vec3 grassAlbedoInner = vec3(0.2549, 0.5961, 0.0392);

void main() {
    // TODO: lambert

    vec3 grassAlbedo = mix(grassAlbedoInner, grassAlbedoOuter, abs(fs_uv.x - 0.5) * 2);
    grassAlbedo *= mix(0.5, 1.0, smoothstep(-0.1, 0.6, fs_uv.y));

    outColor = vec4(grassAlbedo, 1.f);
}
