#version 450
#extension GL_ARB_separate_shader_objects : enable
#define TESS_VALUE 20

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;


layout(location = 0) in vec4 v0[];
layout(location = 1) in vec4 v1[];
layout(location = 2) in vec4 v2[];
layout(location = 3) in vec4 up[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];
layout(location = 3) out vec4 out_up[];
// TODO: Declare tessellation control shader inputs and outputs

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    out_v0[gl_InvocationID] = v0[gl_InvocationID];
    out_v1[gl_InvocationID] = v1[gl_InvocationID];
    out_v2[gl_InvocationID] = v2[gl_InvocationID];
    out_up[gl_InvocationID] = up[gl_InvocationID];

    vec3 cam_pos = inverse(camera.view)[3].xyz;
    float dist = distance(cam_pos, v0[gl_InvocationID].xyz);
	// TODO: Write any shader outputs

	// TODO: Set level of tesselation
   gl_TessLevelInner[0] = TESS_VALUE;
   gl_TessLevelInner[1] = TESS_VALUE;
   gl_TessLevelOuter[0] = TESS_VALUE;
   gl_TessLevelOuter[1] = TESS_VALUE;
   gl_TessLevelOuter[2] = TESS_VALUE;
   gl_TessLevelOuter[3] = TESS_VALUE;
}
