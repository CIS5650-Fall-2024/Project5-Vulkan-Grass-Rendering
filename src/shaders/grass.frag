#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 normal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 lightDirection = normalize(vec3(1,-1,0));
    vec3 grassColor = vec3(0.29, 0.929, 0.173);
    float lambert = max(0,dot(normal,lightDirection));
    vec3 ambient = normalize(vec3(69, 111, 124));

    vec3 new_vert = ambient + lambert * grassColor;

    outColor = vec4(new_vert,1);
}
