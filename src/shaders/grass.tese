#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout (location = 0) in vec4 v0_in[];
layout (location = 1) in vec4 v1_in[];
layout (location = 2) in vec4 v2_in[];
layout (location = 3) in vec4 up_in[];

layout (location = 0) out vec3 pos_out;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    
	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float t = u + 0.5f * v - u * v;

    vec3 dir = vec3(-cos(v0_in[0].w), 0.0f, sin(v0_in[0].w));
    float wid = v2_in[0].w;

    vec3 v0 = vec3(v0_in[0]);
    vec3 v1 = vec3(v1_in[0]);
    vec3 v2 = vec3(v2_in[0]);

    vec3 tmpCenter = v0 * (1.0f - v) * (1.0f - v)+ v1 * v * (1.0f - v) * 2.0f + v2 * v * v;
    vec3 tmpPos = (1 - t) * (tmpCenter - wid * dir) + t * (tmpCenter + wid * dir);

    pos_out = tmpPos;
    gl_Position = camera.proj * camera.view * vec4(tmpPos, 1.0f);
}
