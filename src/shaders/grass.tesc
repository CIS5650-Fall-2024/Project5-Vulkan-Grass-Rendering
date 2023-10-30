#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

# define TESS_GENERAL_LEVEL 20
# define DYNAMIC_LOD 1

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 in_v0[];
layout(location = 1) in vec4 in_v1[];
layout(location = 2) in vec4 in_v2[];
layout(location = 3) in vec4 in_up[];

layout(location = 0) out vec4 out_v0[];
layout(location = 1) out vec4 out_v1[];
layout(location = 2) out vec4 out_v2[];
layout(location = 3) out vec4 out_up[];

void main() {
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// TODO: Write any shader outputs
    out_v0[gl_InvocationID] = in_v0[gl_InvocationID];
    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

    vec3 cam_pos = inverse(camera.view)[3].xyz;
    float dist = distance(cam_pos, in_v0[gl_InvocationID].xyz);

	// TODO: Set level of tesselation
    int LOD = TESS_GENERAL_LEVEL;

#if DYNAMIC_LOD
	if (dist > 20.0)
		LOD = 4;
	else if (dist > 15.0)
		LOD = 8;
	else if (dist > 10.0)
		LOD = 12;
	else if (dist > 5.0)
		LOD = 16;
#endif

    gl_TessLevelInner[0] = LOD;
    gl_TessLevelInner[1] = LOD;
    gl_TessLevelOuter[0] = LOD;
    gl_TessLevelOuter[1] = LOD;
    gl_TessLevelOuter[2] = LOD;
    gl_TessLevelOuter[3] = LOD;
}
