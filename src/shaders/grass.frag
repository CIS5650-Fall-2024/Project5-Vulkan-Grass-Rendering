#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) out vec4 outColor;
vec3 light = vec3(0, 5, 0);
layout(location = 0) in vec3 n;

void main() {
    vec4 minGreen = vec4(0.f, 0.15f, 0.01f, 0.f);
    vec4 maxGreen = vec4(0.05f, 0.9f, 0.01f, 0.f);
    outColor = mix(minGreen, maxGreen, abs(dot(n, normalize(light))));
    //outColor = vec4(0,1,0,0);
}
