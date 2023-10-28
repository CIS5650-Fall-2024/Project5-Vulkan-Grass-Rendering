#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 v0_tese[];
layout(location = 1) in vec4 v1_tese[];
layout(location = 2) in vec4 v2_tese[];
layout(location = 3) in vec4 up_tese[];

layout(location = 0) out vec3 fs_Pos;
layout(location = 1) out vec3 fs_Nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = v0_tese[0].xyz;
    vec3 v1 = v1_tese[0].xyz;
    vec3 v2 = v2_tese[0].xyz;
    vec3 up = up_tese[0].xyz;

    float orientation = v0_tese[0].w;
    //float height = v1_tese[0].w;
    float width = v2_tese[0].w;
    //float stiffness = up_tese[0].w;

    // Bezier curve
    vec3 a = mix(v0, v1, v);
    vec3 b = mix(v1, v2, v);
    vec3 c = mix(a, b, v);

    // Bitangent: direction vector along the width of the blade
    vec3 t1 = vec3(sin(orientation), 0, cos(orientation));
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;
    vec3 t0 = normalize(b - a);

    // Shape
    // float t = u + 0.5f * v - u * v; // triangle
    // float t = u - u * v * v; // quadratic
    float tau = 0.1f;
    float t = 0.5 + (u - 0.5) * (1.0f - max(v - tau, 0.0f) / (1.0f - tau));

    fs_Nor = normalize(cross(t0, t1));
    fs_Pos = mix(c0, c1, t);

    gl_Position = camera.proj * camera.view * vec4(fs_Pos, 1.0f);
}
