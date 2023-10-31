#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

in gl_PerVertex
{
    vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];

layout(location = 0)in vec4 tescv0[];
layout(location = 1)in vec4 tescv1[];
layout(location = 2)in vec4 tescv2[];
layout(location = 3)in vec4 tescup[];

layout(location = 0)out vec4 tesev0[];
layout(location = 1)out vec4 tesev1[];
layout(location = 2)out vec4 tesev2[];
layout(location = 3)out vec4 teseup[];

float lod() {
    vec3 cameraForward = normalize(vec3(camera.view[0].z, camera.view[1].z, camera.view[2].z)); 
    vec3 cameraLoc = -camera.view[3].xyz;
    vec3 v0 = tescv0[0].xyz;
    float dist = length(cameraLoc - v0);
    return max(3, min(15, floor( 14 - dist)));
}

void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    tesev0[gl_InvocationID] = tescv0[gl_InvocationID];
    tesev1[gl_InvocationID] = tescv1[gl_InvocationID];
    tesev2[gl_InvocationID] = tescv2[gl_InvocationID];
    teseup[gl_InvocationID] = tescup[gl_InvocationID];

    float tesselationLevel = lod();
    gl_TessLevelInner[0] = tesselationLevel;
    gl_TessLevelInner[1] = tesselationLevel;
    gl_TessLevelOuter[0] = tesselationLevel;
    gl_TessLevelOuter[1] = tesselationLevel;
    gl_TessLevelOuter[2] = tesselationLevel;
    gl_TessLevelOuter[3] = tesselationLevel;
}
