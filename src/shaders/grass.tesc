#version 450
#extension GL_ARB_separate_shader_objects : enable

// Tessellation Control Shader
// https://www.khronos.org/opengl/wiki/Tessellation#Tessellation_primitive_generation

layout(vertices = 1) out; // only want tessellation points to be generated for each blade once
                          // layout vertices = 1 denotes #blades in output patch, NOT #vertices per patch

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout(location = 0) in vec4[] in_V0; 
layout(location = 1) in vec4[] in_V1;
layout(location = 2) in vec4[] in_V2;

layout(location = 0) out vec4[] out_V0;
layout(location = 1) out vec4[] out_V1;
layout(location = 2) out vec4[] out_V2;

#define TESS_LEVEL 8.0
#define DYNAMIC_TESS_LEVEL 1

// halve the LOD based on camera-to-blade distance
float computeTessLevel(float dist) {
    float lod = TESS_LEVEL;
    if (dist > 10.0) { // hard-coded distance ranges
        lod *= 0.5; 
    }
    if (dist > 20.0) {
        lod *= 0.5;
    }
    return lod;
}

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

	// Write any shader outputs
    out_V0[gl_InvocationID] = in_V0[gl_InvocationID];
    out_V1[gl_InvocationID] = in_V1[gl_InvocationID];
    out_V2[gl_InvocationID] = in_V2[gl_InvocationID];

	// Set level of tesselation
    float lod = TESS_LEVEL;

#if DYNAMIC_TESS_LEVEL
    vec3 camPos = inverse(camera.view)[3].xyz;
    vec3 v0 = in_V0[gl_InvocationID].xyz;
    lod = computeTessLevel(distance(v0, camPos));
#endif

    gl_TessLevelInner[0] = lod;
    gl_TessLevelInner[1] = lod;
    gl_TessLevelOuter[0] = lod;
    gl_TessLevelOuter[1] = lod;
    gl_TessLevelOuter[2] = lod;
    gl_TessLevelOuter[3] = lod;
}
