
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout(location = 0) in vec4 v0;
layout(location = 1) in vec4 v1;
layout(location = 2) in vec4 v2;
layout(location = 3) in vec4 up;

layout(location = 0) out vec4 tescV1;
layout(location = 1) out vec4 tescV2;
layout(location = 2) out vec4 tescUp;

// TODO: Declare vertex shader inputs and outputs

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = vec4((model * vec4(v0.xyz, 1.0)).xyz, v0.w);

    tescV1 =  vec4((model * vec4(v1.xyz, 1.0)).xyz, v1.w);
    tescV2 =  vec4((model * vec4(v2.xyz, 1.0)).xyz, v2.w);
    tescUp =  vec4((model * vec4(up.xyz, 0.0)).xyz, up.w);
}
