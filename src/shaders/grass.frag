#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 uv_in;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 root_color = vec3(34, 139, 34) / 255.f;
    vec3 tip_color =  vec3(124, 252, 0) / 255.f;
    outColor = vec4(mix(root_color, tip_color, uv_in.y), 1.f);
}
