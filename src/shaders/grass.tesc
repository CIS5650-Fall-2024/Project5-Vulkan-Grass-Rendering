#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];

layout(location = 0) out vec4 teV0[];
layout(location = 1) out vec4 teV1[];
layout(location = 2) out vec4 teV2[];

float comptuteLOD(vec3 c, vec3 p) {
    float d = distance(c, p);
    float lod = 1.0;
    if (d > 50.0)
        lod = 1.0;
    else {
        lod = 10.0;
    }
    return 10.0;
}

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    vec3 c = inverse(camera.view)[3].xyz;
    vec3 v0 = inV0[gl_InvocationID].xyz;

	// TODO: Write any shader outputs
    teV0[gl_InvocationID] = inV0[gl_InvocationID];
    teV1[gl_InvocationID] = inV1[gl_InvocationID];
    teV2[gl_InvocationID] = inV2[gl_InvocationID];

	// TODO: Set level of tesselation
    float lod = comptuteLOD(c, v0);
    gl_TessLevelInner[0] = lod;
    gl_TessLevelInner[1] = lod;
    gl_TessLevelOuter[0] = lod;
    gl_TessLevelOuter[1] = lod;
    gl_TessLevelOuter[2] = lod;
    gl_TessLevelOuter[3] = lod;
}
