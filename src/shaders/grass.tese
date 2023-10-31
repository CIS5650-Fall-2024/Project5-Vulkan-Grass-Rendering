#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location = 0)in vec4 tesev0[];
layout(location = 1)in vec4 tesev1[];
layout(location = 2)in vec4 tesev2[];
layout(location = 3)in vec4 teseup[];

layout(location=0)out vec3 n;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    float orientationAngle = tesev0[0].w;
    float height = tesev1[0].w;
    float width = tesev2[0].w;

    vec3 v0 = tesev0[0].xyz;
    vec3 v1 = tesev1[0].xyz;
    vec3 v2 = tesev2[0].xyz;
    
    vec3 orientation = vec3(cos(orientationAngle), 0, -sin(orientationAngle)); //isolating the first column of the Ry rotation matrix

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * orientation;
    vec3 c1 = c + width * orientation;

    vec3 t0 = normalize(b - a);
    n = normalize(cross(t0, orientation));
    float t;
    //t = u; //quad
    t = u + 0.5 * v - u * v;    //triangle
    //t = u - u * v * v; //quadratic/parabola
    vec3 finalPos = mix(c0, c1, t);
    gl_Position = camera.proj * camera.view * vec4(finalPos, 1.f);
}
