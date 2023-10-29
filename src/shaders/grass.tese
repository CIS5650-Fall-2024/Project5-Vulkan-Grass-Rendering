#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(triangles, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 tes_v1[];
layout(location = 1) in vec4 tes_v2[];
layout(location = 2) in vec4 tes_up[];

layout(location = 0) out vec4 fs_pos;
layout(location = 1) out vec4 fs_nor;
layout(location = 2) out vec2 fs_UV;

// These t functions are described in section 6.3 of the paper
float getQuadT(const float u, const float v)
{
    return u;
}

float getTriT(const float u, const float v)
{
    return u + 0.5 * v + u * v;
}

float getQuadraticT(const float u, const float v)
{
    return u - u * v * v;
}

float getTriTipT(const float u, const float v)
{
    float tau = 0.3;
    return 0.5 + (u - 0.5) * (1 - (max(v - tau, 0.0)/1.0 - tau));
}

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
        gl_Position = camera.proj * camera.view * gl_in[0].gl_Position;
    
    // first element of arrays because we only have 1 vertex in patch!
    vec3 v0 = gl_in[0].gl_Position.xyz;
    vec3 v1 = tes_v1[0].xyz;
    vec3 v2 = tes_v2[0].xyz;

    float angle = gl_in[0].gl_Position.w;
    float height = tes_v1[0].w;
    float width = tes_v2[0].w;
    float stiff_coeff = tes_up[0].w;
    
    // From section 6.3 in the paper
    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);

    vec3 t1 = vec3(1,0,0);//vec3(cos(angle), 0.0f, sin(angle));     // fast matrix multiplication for y rotation of vec3.right (1,0,0)
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    vec3 t0 = normalize(b - a);
    fs_nor = vec4(normalize(cross(t0, t1)), 0.0);
    
    float t = getTriTipT(u, v);
    
    vec4 pos = vec4(mix(c0, c1, t), 1.0);
    gl_Position = camera.proj * camera.view * pos;
    fs_pos = pos;
    fs_UV = vec2(u, v);
}
