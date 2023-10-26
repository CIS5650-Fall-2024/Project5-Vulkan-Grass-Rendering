#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout (location = 0) in vec3 pos_in;

layout(location = 0) out vec4 color_out;

void main() {
    // TODO: Compute fragment color
    vec3 tipColor = vec3(0.23f, 0.59f, 0.22f);
    vec3 baseColor = vec3(0.13f, 0.44f, 0.12f);
    color_out = vec4(tipColor * pos_in.y + baseColor * (1.0f - pos_in.y), 0.5f);
}
