#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_pos;
layout(location = 1) in vec3 in_nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 baseColor = vec3(0.4, 0.7, 0.2);
    vec3 ambient = vec3(0.2, 0.3, 0.1);
    
    vec4 light_pos = vec4(10.0, 30.0, 0.0, 1.0);
    vec4 nor = vec4(normalize(in_nor), 0.0);
    vec4 L = normalize(light_pos - vec4(in_pos, 1.0f));

    float diffuse = max(dot(L, nor), 0.0);
    vec3 color = ambient + diffuse * baseColor;

    outColor = vec4(color, 1.0);
}
