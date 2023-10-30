#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_in[];
layout(location = 1) in vec4 v1_in[];
layout(location = 2) in vec4 v2_in[];
layout(location = 3) in vec4 up_in[];

layout(location = 0) out vec2 uv_out; 

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    uv_out = vec2(u, v);

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = v0_in[0].xyz;
    vec3 v1 = v1_in[0].xyz;
    vec3 v2 = v2_in[0].xyz;
    
    float theta = v0_in[0].w;
    float width = v2_in[0].w;

    vec3 t1 = normalize(vec3(-cos(theta), 0.f, sin(theta)));

    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);
    
    vec3 t0 = normalize(b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    
    float t = u + 0.5f * v - u * v;
    vec4 pos = vec4(mix(c0, c1, t), 1.f);
    gl_Position = camera.proj * camera.view * pos;
}
