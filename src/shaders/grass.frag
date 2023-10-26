#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 pos_in;
layout(location = 1) in vec3 nor_in;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 albedo = vec3(0.1, 0.8, 0.1);
    vec3 ambient = vec3(0.1, 0.3, 0.1);

    vec3 lightPos = vec3(10.0, 20.0, 10.0);
    vec3 lightDir = lightPos - pos_in;

    vec3 nor = nor_in;
    float lambert = max(0.0, dot(normalize(lightDir), nor));

    vec3 color = ambient + albedo * lambert;

    outColor = vec4(color, 1.0);
}
