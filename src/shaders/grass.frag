#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 nor;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 baseColor = vec3(0.15, 0.8, 0.2);
    vec3 ambientColor = vec3(0.1, 0.2, 0.1);

    vec4 lightPos = vec4(10.0, 20.0, 0.0, 1.0);
    vec4 surfaceNormal = vec4(normalize(nor), 0.0);
    vec4 vecToLight = normalize(lightPos - vec4(pos, 1.0));

    float diffuse = max(dot(surfaceNormal, vecToLight), 0.0);
    vec3 diffuseColor = baseColor * diffuse + ambientColor;

    outColor = vec4(diffuseColor, 1.0);
    //outColor = vec4(0.0, 1.0, 0.0, 1.0);
}
