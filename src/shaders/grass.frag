#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs
layout(location = 0) in vec2 in_uv;
layout(location = 1) in vec3 in_pos;
layout(location = 2) in vec3 in_norm;

layout(location = 0) out vec4 outColor;

void main() {
    // Compute fragment color

    vec4 tip_col = vec4(0, 0.8, 0, 1);
    vec4 root_col = vec4(0, 0.1, 0.05, 1);
    outColor = root_col + (in_uv.y) * (tip_col - root_col);
}
