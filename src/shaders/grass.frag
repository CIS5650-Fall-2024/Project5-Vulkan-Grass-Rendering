#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 uv;

layout(location = 0) out vec4 outColor;

void main() 
{
    // lambert

    // use view dir as light dir
    const vec3 light_dir = normalize(transpose(camera.view)[2].xyz);

    const vec3 top = vec3(0.1f, 0.9f, 0.1f);
    const vec3 buttom = vec3(0.1f, 0.4f, 0.1f);

    const vec3 base_color = mix(buttom, top, uv.y);

    outColor = vec4(base_color * abs(dot(light_dir, normal)), 1.0);
}
