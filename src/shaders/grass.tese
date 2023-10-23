#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

layout(location = 0) in vec4 tes_v1[];
layout(location = 1) in vec4 tes_v2[];
layout(location = 2) in vec4 tes_up[];

layout(location = 0) out vec3 fs_pos;
layout(location = 1) out vec3 fs_nor;
layout(location = 2) out vec2 fs_uv;

float tQuad(float u, float v) {
    return u;
}

float tTriangle(float u, float v) {
    return u + 0.5f * v - u * v;
}

float tParabola(float u, float v) {
    return u - u * v * v;
}

const float tau = 0.7f;
float tTriangleTip(float u, float v) {
    return 0.5f + (u - 0.5f) * (1.f - max(v - tau, 0.f) / (1.f - tau));
}

void main() {
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;
    
    const vec3 v0 = gl_in[0].gl_Position.xyz;
    const float theta = gl_in[0].gl_Position.w;

    const vec3 v1 = tes_v1[0].xyz;
    const vec3 v2 = tes_v2[0].xyz;
    const vec3 up = tes_up[0].xyz;
    const float w = tes_v2[0].w; // width
    
    const vec3 a = v0 + v * (v1 - v0);
    const vec3 b = v1 + v * (v2 - v1);
    const vec3 c = a + v * (b - a);
    const vec3 t1 = vec3(cos(theta), 0, sin(theta));  // bitangent (blade width)
    const vec3 c0 = c - w * t1;                       // min x-axis point
    const vec3 c1 = c + w * t1;                       // max x-axis point
    const vec3 t0 = normalize(b - a);                 // tangent (blade height)
    const vec3 n = normalize(cross(t0, t1));          // normal

    const float t = tParabola(u, v);
    const vec3 pos = (1.f - t) * c0 + t * c1;

    gl_Position = camera.proj * camera.view * vec4(pos, 1.0);

    fs_pos = pos;
    fs_nor = n;
    fs_uv = vec2(u, v);
}
