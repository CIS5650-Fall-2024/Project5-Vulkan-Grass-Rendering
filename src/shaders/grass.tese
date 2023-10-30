#version 450
#extension GL_ARB_separate_shader_objects : enable

#define tParabola(u, v) (u - u * v * v)

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 tes_v1[];
layout(location = 1) in vec4 tes_v2[];
layout(location = 2) in vec4 tes_up[];

layout(location = 0) out vec3 fs_pos;
layout(location = 1) out vec3 fs_nor;
layout(location = 2) out vec2 fs_uv;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0 = gl_in[0].gl_Position.xyz;
    vec3 v1 = tes_v1[0].xyz;
    vec3 v2 = tes_v2[0].xyz;
    vec3 up = tes_up[0].xyz;

    float theta = gl_in[0].gl_Position.w;
    vec3 t1 = vec3(cos(theta), 0, sin(theta)); // bitangent
    float w = tes_v2[0].w;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;
    vec3 t0 = normalize(b - a);
    vec3 n = normalize(cross(t0, t1));

    float t = tParabola(u, v);
    vec3 pos = (1 - t) * c0 + t * c1;

    gl_Position = camera.proj * camera.view * vec4(pos, 1.f); // project to clip space

    fs_pos = pos; // world space for fragment shader
    fs_nor = n;
    fs_uv = vec2(u,v);
}
