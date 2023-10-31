#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in float h;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 a = vec3(0.3, 0.7, 0.2);
    vec3 b = vec3(0.1, 0.5, 0.2);
    vec3 col = mix(b, a, h);
    outColor = vec4(col, 1.0);
}
