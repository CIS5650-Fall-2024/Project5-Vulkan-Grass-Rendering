
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
// v0: the position of the grass blade on the geomtry
// v1: a Bezier curve guide that is always "above" v0 with respect to the grass blade's up vector (explained soon)
// v2: a physical guide for which we simulate forces on
// v0.w holds orientation, v1.w holds height, v2.w holds width, and up.w holds the stiffness coefficient.
layout(location = 0) in vec4 inV0;
layout(location = 1) in vec4 inV1;
layout(location = 2) in vec4 inV2;
layout(location = 3) in vec4 inUp;

out gl_PerVertex {
    vec4 gl_Position;
};

// layout(location = 0) out vec3 fragColor;
// layout(location = 1) out vec2 fragTexCoord;
layout(location = 0) out vec4 outV0;
layout(location = 1) out vec4 outV1;
layout(location = 2) out vec4 outV2;
layout(location = 3) out vec4 outUp;

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = model * vec4(inV0.xyz,1.0);
    
    outV0 = gl_Position;
    outV1 = model * vec4(inV1.xyz,1.0);
    outV2 = model * vec4(inV2.xyz,1.0);
    outUp = model * vec4(inUp.xyz,0.0);
    
    outV0.w = inV0.w;
    outV1.w = inV1.w;
    outV2.w = inV2.w;
    outUp.w = inUp.w;
}
