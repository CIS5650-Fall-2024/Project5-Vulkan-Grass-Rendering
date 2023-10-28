#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
    mat4 invView;
} camera;

layout(location = 0) in vec4 v1[];
layout(location = 1) in vec4 v2[];
layout(location = 2) in vec4 up[];

layout(location = 0) out vec4 fs_Nor;
layout(location = 1) out vec4 fs_L;
layout(location = 2) out float height;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 curr_v0 = gl_in[0].gl_Position.xyz;
    vec3 curr_v1 = v1[0].xyz;
    vec3 curr_v2 = v2[0].xyz;
    vec3 curr_up = up[0].xyz;

    vec3 a = curr_v0 + v * (curr_v1 - curr_v0);
    vec3 b = curr_v1 + v * (curr_v2 - curr_v1);
    vec3 c = a + v * (b - a);

    vec3 t1 = vec3(cos(gl_in[0].gl_Position.w), 0.0, sin(gl_in[0].gl_Position.w));
    vec3 c0 = c - v2[0].w * t1;
    vec3 c1 = c + v2[0].w * t1;
    
    vec3 t0 = normalize(b - a);
    vec3 n = normalize(cross(t0, t1));

    float t = 0.5 + (u - 0.5) * (u - u * v * v);
    gl_Position = camera.proj * camera.view * vec4((1.0 - t) * c0 + t * c1, 1.0);

    fs_Nor = vec4(n, 1.0);
    fs_L = camera.invView * vec4(0.0, 0.0, 0.0, 1.0) - vec4(curr_v0, 1.0);
    height = v + 0.5;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}
