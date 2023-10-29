#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// DONE: Declare fragment shader inputs
layout(location = 0) in vec3 inPos;
layout(location = 1) in vec3 inNor;

layout(location = 0) out vec4 outColor;

void main() {
    // DONE: Compute fragment color
    vec3 albedo = vec3(0.1, 0.8, 0.1);
    vec3 ambient = vec3(0.1, 0.3, 0.1);
    vec3 lightPos = vec3(10.0, 20.0, 10.0);
    vec3 lightDir = normalize(lightPos - inPos);
    float lambert = max(0.0, dot(lightDir, inNor));

    outColor = vec4(ambient + albedo * lambert, 1.0);
}
