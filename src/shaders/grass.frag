#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;



layout(location = 0) in vec3 grassNormal;
layout(location = 1) in vec3 grassPosition;

layout(location = 0) out vec4 outColor;

void main() {

    vec3 lightDir = normalize(vec3(1.0f, 1.0f, 1.0f));

    float lambertian = min(max(dot(grassNormal, lightDir), 0.0f) + 0.4f, 1.0f);

    vec3 grassGreen = vec3(0.1f, 0.7f, 0.2f);

    outColor = vec4(grassGreen * lambertian, 1.0f);
}
