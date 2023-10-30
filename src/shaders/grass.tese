#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

in gl_PerVertex {
    vec4 gl_Position;
} gl_in[];


layout(location = 0) in vec4 in_v1[];
layout(location = 1) in vec4 in_v2[];
layout(location = 2) in vec4 in_up[];

layout(location = 0) out vec3 normal;
layout(location = 1) out float heightRatio;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec4 v0 = gl_in[0].gl_Position;
    vec4 v1 = in_v1[0];
    vec4 v2 = in_v2[0];
    vec4 up = in_up[0];

    float width = v2.w;
    float height = v1.w;

    vec3 a = v0.xyz + v * (v1.xyz - v0.xyz); // vertical point
    vec3 b = v1.xyz + v * (v2.xyz - v1.xyz); // horizontal point
    vec3 c = a + v * (b - a);
    vec3 t1 = vec3(cos(v0.w), 0, sin(v0.w)); // bitangent
    vec3 t0 = normalize(b - a); // tangent
    normal = normalize(cross(t0, t1));

    const float r = 0.35;
    float t = 0.5 + (u - 0.5) * (1 - max(v - r, 0) / (1 - r));
    // t = u + 0.5 * v - u * v, triangles 
    // t = u, square
    vec3 pos = c + (t - 0.5) * width * t1;
    
    gl_Position = camera.proj * camera.view * vec4(pos, 1);
    
    // heightRatio = pos.y / v2.y;
    heightRatio = dot(pos - v0.xyz, up.xyz) / v1.w;
}
