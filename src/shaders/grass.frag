#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) out vec4 outColor;

layout(location = 0) in vec3 grassNormal;

void main() {
    // TODO: Compute fragment color

    vec3 lightDir = normalize(vec3(0.0f, 100.0f, 0.0f));

    float lambertian = max(dot(grassNormal, lightDir), 0.0f);

    vec4 grassGreen = vec4(0.1f, 0.7f, 0.2f, 1.0f);

    outColor = grassGreen * lambertian;
}
