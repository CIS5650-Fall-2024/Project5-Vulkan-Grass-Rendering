#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 tes_v0[];
layout(location = 1) in vec4 tes_v1[];
layout(location = 2) in vec4 tes_v2[];
layout(location = 3) in vec4 tes_up[];

layout(location = 0) out vec4 pos;     
layout(location = 1) out vec3 normal;    
layout(location = 2) out vec2 uv;   

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade

    vec3 v0 = tes_v0[0].xyz;
    vec3 v1 = tes_v1[0].xyz;
    vec3 v2 = tes_v2[0].xyz;
    vec3 up = tes_up[0].xyz;

    float width = tes_v2[0].w;
    // The bitangent t1 is given directly by the direction vector along the width of the blade

    vec3 t1 = normalize(vec3(sin(tes_v0[0].w), 0.f, cos(tes_v0[0].w)));

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    vec3 t0 = normalize(b - a);
    vec3 normal = normalize(cross(t0, t1));

    // Quad:        
    // t = u
    // Triangle:     
    //t = u + 0.5 * v - u * v
    // Quadratic:   
    //t = u - u * v * v
    // Triangle-tip:
    //t = 0.5 + (u - 0.5) * (1 - max(v - threshold, 0) / (1 - threshold))
    float t = u - u * v * v;

    pos = vec4(mix(c0, c1, t), 1.f);
    uv = vec2(u, v);

    gl_Position = camera.proj * camera.view * pos;
}
