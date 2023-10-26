#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    vec4 fwd;
    vec4 pos;
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 inColor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    outColor = vec4(inColor,1.0);
}
