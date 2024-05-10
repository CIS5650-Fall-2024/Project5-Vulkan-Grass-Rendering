#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs
layout(location = 0) in float fs_V;
layout(location = 1) in vec3 fs_Nor;

layout(location = 0) out vec4 outColor;

void main() {
    // blade base albedo
    vec3 rootColor = vec3(103, 139, 61) / 255.0;
    vec3 tipColor =  vec3(68, 92, 41) / 255.0; //vec3(0.0, 0.98, 0.0);
    vec3 albedo = mix(rootColor, tipColor, fs_V);

    // diffuse lighting
    vec3 lightDir = vec3(0.0, 1.0, 0.0);
    float ambientTerm = 1.0;

    float diffuseTerm = dot(normalize(fs_Nor), normalize(lightDir));
    diffuseTerm = clamp(diffuseTerm, 0.0, 1.0);

    vec3 result = albedo * (ambientTerm + diffuseTerm);

    outColor = vec4(result, 1.0);
}
