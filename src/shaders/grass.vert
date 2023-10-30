
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

layout(location = 0) in vec4 blade_v0;
layout(location = 1) in vec4 blade_v1;
layout(location = 2) in vec4 blade_v2;
layout(location = 3) in vec4 blade_up;

layout(location = 0) out vec4 blade_v0_out;
layout(location = 1) out vec4 blade_v1_out;
layout(location = 2) out vec4 blade_v2_out;
layout(location = 3) out vec4 blade_up_out;

out gl_PerVertex {
    vec4 gl_Position;
    float gl_PointSize;
    float gl_ClipDistance[];
};

void main() {

    gl_Position =  model * vec4(blade_v0.xyz, 1.0);

    blade_v0_out = model * vec4(blade_v0.xyz, 1.0);
    blade_v1_out = model * vec4(blade_v1.xyz, 1.0);
    blade_v2_out = model * vec4(blade_v2.xyz, 1.0);
    blade_up_out = model * vec4(blade_up.xyz, 1.0);

    blade_v0_out.w = blade_v0.w;
    blade_v1_out.w = blade_v1.w;
    blade_v2_out.w = blade_v2.w;
    blade_up_out.w = blade_up.w;
}
