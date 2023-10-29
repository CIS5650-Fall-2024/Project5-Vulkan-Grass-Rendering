#version 450
#extension GL_ARB_separate_shader_objects : enable

#define minTessLevel 3.0
#define maxTessLevel 10.0
#define minDistance 1.0
#define maxDistance 30.0

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 v0_tesc[];
layout(location = 1) in vec4 v1_tesc[];
layout(location = 2) in vec4 v2_tesc[];
layout(location = 3) in vec4 up_tesc[];

layout(location = 0) out vec4 v0_tese[];
layout(location = 1) out vec4 v1_tese[];
layout(location = 2) out vec4 v2_tese[];
layout(location = 3) out vec4 up_tese[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// Write any shader outputs
    v0_tese[gl_InvocationID] = v0_tesc[gl_InvocationID];
    v1_tese[gl_InvocationID] = v1_tesc[gl_InvocationID];
    v2_tese[gl_InvocationID] = v2_tesc[gl_InvocationID];
    up_tese[gl_InvocationID] = up_tesc[gl_InvocationID];

	// Set level of tesselation
    vec3 c = vec3(inverse(camera.view) * vec4(0, 0, 0, 1)); // position of camera
    float d = length(c - gl_in[0].gl_Position.xyz);

    float tessRange = maxTessLevel - minTessLevel;
    float rDistRange = 1.0f / (maxDistance - minDistance);
    float level = minTessLevel + tessRange * (1.0f - clamp((d - minDistance) * rDistRange, 0.0f, 1.0f));

    gl_TessLevelInner[0] = 1.0f;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = 1.0f;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = 1.0f;
}
