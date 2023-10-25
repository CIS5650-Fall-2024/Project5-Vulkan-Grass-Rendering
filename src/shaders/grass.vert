
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
	mat4 proj;
} camera;

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Grass blade data structure
struct GrassBlade {
    vec4 v0; // control point 0 + orientation
    vec4 v1; // control point 1 + height
    vec4 v2; // control point 2 + width
    vec4 up; // up vector + stiffness coefficient
};


layout(location = 0) in GrassBlade grassBladeIn;
layout(location = 0) out GrassBlade grassBladeOut;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// Passing grass blade data to the next shader stage
    grassBladeOut = grassBladeIn;

    // For now, just transforming the first control point to clip space as a placeholder
    // You may need to replace this with appropriate logic based on your actual needs
    vec4 worldPosition = camera.view * camera.proj * vec4(grassBladeIn.v0.xyz, 1.0);
    gl_Position = worldPosition;
}
