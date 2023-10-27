#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 fs_position;
layout(location = 1) in vec3 fs_normal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 base = vec3(0.1, 0.8, 0.1);
    vec3 ambient = vec3(0.1, 0.3, 0.1);
    vec3 lightPos = vec3(10.0, 60.0, 10.0);
    vec3 normal = normalize(fs_normal);
    vec3 lightDir = normalize(lightPos - fs_position);
    float diffuse = max(dot(lightDir, normal), 0.0);
    vec3 lightColor = vec3(1.0, 1.0, 1.0);
    vec3 diffuseColor = lightColor * diffuse;
    vec3 result = (ambient + diffuseColor) * base;
    outColor = vec4(result, 1.0);
}
