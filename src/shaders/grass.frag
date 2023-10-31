#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare fragment shader inputs
layout(location = 0) in vec4 pos;     
layout(location = 1) in vec3 normal;    
layout(location = 2) in vec2 uv;    

// Output color of the fragment
layout(location = 0) out vec4 outColor;


void main() {
    // Base colors
    vec3 bottom  = vec3(0.0, 0.5, 0.0); 
    vec3 top   = vec3(0.0, 0.8, 0.0); 
    vec3 base_color = mix(bottom, top, uv[1]);

    // Lighting setup
    vec3 lightDir = normalize(vec3(0.0, 1.0, 0.0)); // generic light direction from the second shader
    float diffuseTerm = clamp(dot(normal, lightDir), 0.0, 1.0);
    float ambientTerm = 0.2;

    // Final lighting intensity
    float lightIntensity = diffuseTerm + ambientTerm;

    // Combine base color with lighting to get the final color
    //outColor = vec4(lightIntensity * base_color, 1.0);
    outColor = vec4(base_color, 1.0);
}

