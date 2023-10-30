#version 450
#extension GL_ARB_separate_shader_objects : enable

#define LOD_HIGH 10
#define LOD_LOW 1

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 tcs_v1[];
layout(location = 1) in vec4 tcs_v2[];
layout(location = 2) in vec4 tcs_up[];

layout(location = 0) out vec4 tes_v1[];
layout(location = 1) out vec4 tes_v2[];
layout(location = 2) out vec4 tes_up[];

in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// Write any shader outputs
    tes_v1[gl_InvocationID] = tcs_v1[gl_InvocationID];
    tes_v2[gl_InvocationID] = tcs_v2[gl_InvocationID];
    tes_up[gl_InvocationID] = tcs_up[gl_InvocationID];

    float dist = distance(gl_out[gl_InvocationID].gl_Position.xyz, camera.invView[3].xyz);
    float t = smoothstep(15, 1, dist);

    int tesselationLevel = int(ceil(mix(LOD_LOW, LOD_HIGH, t)));

	// Set level of tesselation
    gl_TessLevelInner[0] = tesselationLevel;
    gl_TessLevelInner[1] = tesselationLevel;
    gl_TessLevelOuter[0] = tesselationLevel;
    gl_TessLevelOuter[1] = tesselationLevel;
    gl_TessLevelOuter[2] = tesselationLevel;
    gl_TessLevelOuter[3] = tesselationLevel;
}
