#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare fragment shader inputs
layout(location = 0) in vec2 inUV;
layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    float u = abs(inUV.x-0.5f)*2.0f;
    vec3 col = mix(vec3(0.208,0.469,0.231),vec3(0.0,0.6,0.0),u);
    col = mix(col,vec3(0.1,0.3,0.1), 1.0-inUV.y);
    
    outColor = vec4(col,1.0f);
    //outColor = vec4(1.0f);
}
