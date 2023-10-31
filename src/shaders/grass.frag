#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout(location = 0) in vec3 normal;
layout(location = 1) in float heightFraction; // Interpolated value between 0 (base) and 1 (tip)

layout(location = 0) out vec4 outColor;

void main() {
    vec4 darkGreen = vec4(0.0, 0.3, 0.0, 1.0);
    vec4 midGreen = vec4(0.0, 0.6, 0.0, 1.0);
    vec4 lightGreen = vec4(0.2, 0.9, 0.2, 1.0);

    vec3 upDirection = vec3(0.0, 1.0, 0.0);
    float angleCosine = abs(dot(upDirection, normal));
    vec4 baseColor = mix(darkGreen, lightGreen, angleCosine);

    vec4 tipColor = mix(midGreen, lightGreen, heightFraction);
    vec4 finalColor = mix(baseColor, tipColor, 0.5);

    outColor = finalColor;
}
