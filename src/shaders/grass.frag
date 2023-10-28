#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs
layout(location = 0) in vec3 fs_Pos;
layout(location = 1) in vec3 fs_Nor;

layout(location = 0) out vec4 outColor;

const vec3 green = vec3(0.11f, 0.62f, 0.0f);
const vec3 lightPos = vec3(0.0f, 50.0f, 15.0f);

void main() {
    // Compute fragment color

    // Blinn-Phong
    vec4 diffuseColor = vec4(green, 1.0f);

    vec3 fs_LightVec = normalize(lightPos - fs_Pos);
    float diffuseTerm = clamp(dot(normalize(fs_Nor), fs_LightVec), 0.0, 1.0);
    float ambientTerm = 1.2f;

    // vec4 fs_HalfVec = normalize((fs_CameraPos - fs_Pos + fs_LightVec) / 2.f);
    // float specularTerm = max(pow(dot(fs_HalfVec, normalize(fs_Nor)), 20.0), 0.0);

    float lightIntensity = diffuseTerm + ambientTerm; // + specularTerm

    outColor = vec4(diffuseColor.rgb * lightIntensity, 1.0f);
}
