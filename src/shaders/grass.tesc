#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs

in gl_PerVertex {
    vec4 gl_Position;
}gl_in[];

out gl_PerVertex {
    vec4 gl_Position;
}gl_out[];

layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

layout(location = 0) out vec4 out_v1[];
layout(location = 1) out vec4 out_v2[];
layout(location = 2) out vec4 out_up[];

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;


    out_v1[gl_InvocationID] = in_v1[gl_InvocationID];
    out_v2[gl_InvocationID] = in_v2[gl_InvocationID];
    out_up[gl_InvocationID] = in_up[gl_InvocationID];

	// TODO: Write any shader outputs

	// TODO: Set level of tesselation

    vec3 v0 = gl_in[gl_InvocationID].gl_Position.xyz;
    vec3 up = in_up[gl_InvocationID].xyz;
    vec3 cam = (inverse(camera.view) * vec4(0, 0, 0, 1)).xyz;
    float d_proj = length(v0 - cam - up * dot((v0 - cam), up));
    float d_min = 8;
    float d_max = 25;
    float r = clamp((d_proj - d_min) / (d_max - d_min), 0.0, 1.0);
    // r = r * r;

    uint innerLevel = uint(round(3 * (1 - r)));
    uint outerLevel = uint(round(8 * (1 - r)));

    gl_TessLevelInner[0] = innerLevel;
    gl_TessLevelInner[1] = innerLevel;

    gl_TessLevelOuter[0] = outerLevel;
    gl_TessLevelOuter[1] = outerLevel;
    gl_TessLevelOuter[2] = outerLevel;
    gl_TessLevelOuter[3] = outerLevel;
    
}
