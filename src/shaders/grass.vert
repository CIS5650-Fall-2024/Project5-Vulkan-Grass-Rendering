
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// TODO: Declare vertex shader inputs and outputs
layout(location=0) in vec4 v0;
layout(location=1) in vec4 v1;
layout(location=2) in vec4 v2;
layout(location=3) in vec4 v3;

layout(location=0) out vec4 outv0;
layout(location=1) out vec4 outv1;
layout(location=2) out vec4 outv2;
layout(location=3) out vec4 outv3;

out gl_PerVertex {
   vec4 gl_Position;
};

void main() {
	// TODO: Write gl_Position and any other shader outputs
    gl_Position = model * vec4(v0.xyz, 1.0);
    outv0=vec4(vec3(model*vec4(vec3(v0),1.0f)),v0.w);
    outv1=vec4(vec3(model*vec4(vec3(v1),1.0f)),v1.w);
    outv2=vec4(vec3(model*vec4(vec3(v2),1.0f)),v2.w);
    outv3=vec4(vec3(model*vec4(vec3(v3),1.0f)),v3.w);
}
