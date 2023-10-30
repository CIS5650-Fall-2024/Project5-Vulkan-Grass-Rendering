#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 fs_pos;
layout(location = 1) in vec3 fs_nor;
layout(location = 2) in vec2 fs_uv;

layout(location = 0) out vec4 outColor;

const vec3 grassAlbedoEdge = vec3(0.075,0.427,0.082);
const vec3 grassAlbedoCenter = vec3(0.255,0.596,0.039);

void main() {
    // TODO: Compute fragment color
    vec3 grassAlbedo = mix(grassAlbedoCenter, grassAlbedoEdge, abs(fs_uv.x - 0.5) * 2);
    grassAlbedo *= mix(0.6, 1.0, smoothstep(0.f, 0.7, fs_uv.y)); 
    outColor = vec4(grassAlbedo, 1.f);
}
