#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

layout(location = 0) out vec4 outColor;

layout(location = 0) in vec4 N;
layout(location = 1) in vec4 L;
layout(location = 2) in float height;

void main() {
    float diffuse = abs(dot(normalize(N), normalize(L)));
    diffuse = clamp(diffuse, 0.0, 0.8);

    float amb = 0.2;
    float intensity = diffuse + amb;

    outColor = vec4(0.0, 1.0, 0.0, 1.0) * intensity * (height / 1.5);
}
