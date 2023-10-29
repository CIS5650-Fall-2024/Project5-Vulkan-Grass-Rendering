#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 in_normal;
layout(location = 1) in vec3 in_pos;

layout(location = 0) out vec4 outColor;

vec3 lightpos=vec3(10.0f,10.0f,10.0f);

void main() {
    // TODO: Compute fragment color
    float mag=abs(dot(normalize(lightpos-in_pos),in_normal));
    mag=clamp(mag+0.3f,0.0f,1.0f);
    outColor = mag*vec4(0.1f,0.54f,0.0f,1.0f);
}
