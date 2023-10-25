#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

layout(location = 0) in vec4 v1[];
layout(location = 1) in vec4 v2[];
layout(location = 2) in vec4 up[];

layout(location = 0) out vec4 tescV1[];
layout(location = 1) out vec4 tescV2[];
layout(location = 2) out vec4 tescUp[];

in gl_PerVertex
{
  vec4 gl_Position;
} gl_in[gl_MaxPatchVertices];


void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    tescV1[gl_InvocationID] = v1[gl_InvocationID];
    tescV2[gl_InvocationID] = v2[gl_InvocationID];
    tescUp[gl_InvocationID] = up[gl_InvocationID];

    gl_TessLevelInner[0] = 10;
    gl_TessLevelInner[1] = 10;
    gl_TessLevelOuter[0] = 10;
    gl_TessLevelOuter[1] = 10;
    gl_TessLevelOuter[2] = 10;
    gl_TessLevelOuter[3] = 10;
}
