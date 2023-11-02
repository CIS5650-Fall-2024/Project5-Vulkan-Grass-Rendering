#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec3 pos;
layout(location = 1) in vec3 nor;
layout(location = 2) in float height;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 baseColor = vec3(0.4, 0.75, 0.15);
    vec3 ambientColor = vec3(0.0, 0.17, 0.0);

//    vec4 lightPos = inverse(camera.view) * vec4(0.0, 0.0, 0.0, 1.0) - inverse(camera.view) * vec4(pos, 1.0);
    vec4 lightPos = vec4(10, 10, 20, 1.0);
    vec4 surfaceNormal = vec4(normalize(nor), 0.0);
    vec4 vecToLight = normalize(lightPos - vec4(pos, 1.0));

    float diffuse = abs(dot(surfaceNormal, vecToLight));
    diffuse = clamp(diffuse, 0.0, 1.0);
    vec3 diffuseColor = baseColor * diffuse + ambientColor;

    outColor = vec4(diffuseColor, 1.0) * (height + 0.25) * 0.85;
    //outColor = vec4(0.0, 1.0, 0.0, 1.0);
}
