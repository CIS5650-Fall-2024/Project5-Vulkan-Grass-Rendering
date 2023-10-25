#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

struct GrassBlade {
    vec4 v0; // control point 0 + orientation
    vec4 v1; // control point 1 + height
    vec4 v2; // control point 2 + width
    vec4 up; // up vector + stiffness coefficient
};

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in GrassBlade grassBladeIn;

layout(location = 0) out vec3 grassNormal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    float width = grassBladeIn.v2.x;
    float height = grassBladeIn.v1.x;
    float orientation = grassBladeIn.v0.w;

    vec3 t1 = normalize(vec3(sin(orientation), 0.0, cos(orientation)));

    vec3 a = grassBladeIn.v0.xyz; + v * (grassBladeIn.v1.xyz - grassBladeIn.v0.xyz);
    vec3 b = grassBladeIn.v1.xyz + v * (grassBladeIn.v2.xyz - grassBladeIn.v1.xyz);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    vec3 t0 = normalize(b - a); 
    vec3 normal = normalize(cross(t0, t1));

    float t = u + 0.5 * v - u * v;

    vec3 position = (1 - t) * c0 + t * c1;

    gl_Position = camera.proj * camera.view * vec4(position, 1.0);

}
