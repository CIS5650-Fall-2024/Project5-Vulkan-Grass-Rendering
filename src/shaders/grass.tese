#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];

layout(location = 0) out vec3 fs_position;
layout(location = 1) out vec3 fs_normal;

void main() {
    const float u = gl_TessCoord.x;
    const float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    const vec3 v0 = inV0[0].xyz;
    const vec3 v1 = inV1[0].xyz;
    const vec3 v2 = inV2[0].xyz;


    const vec3 a = mix(v0, v1, v);
    const vec3 b = mix(v1, v2, v);
    const vec3 c = mix(a, b, v);

    const float phi = inV0[0].w;
    const vec3 t1 = normalize(vec3(cos(phi), 0.f, sin(phi)));
    const vec3 t0 = normalize(b - a);
    const float width  = inV2[0].w;
    const vec3 c0 = c - width * t1;
    const vec3 c1 = c + width * t1;
    fs_normal = normalize(cross(t0, t1));

    const float t = mix(u, 0.5f, v);
    const vec3 p = mix(c0, c1, t);
    fs_position  = p;

    gl_Position = camera.proj * camera.view * vec4(p, 1.f);
}
