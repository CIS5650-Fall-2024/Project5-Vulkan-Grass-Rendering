#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec4 v0[];
layout(location = 1) in vec4 v1[];
layout(location = 2) in vec4 v2[];
layout(location = 3) in vec4 up[];

layout(location = 0) out vec3 out_pos;
layout(location = 1) out vec3 out_nor;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 v0_3 = v0[0].xyz;
    vec3 v1_3 = v1[0].xyz;
    vec3 v2_3 = v2[0].xyz;
    vec3 up_3 = up[0].xyz;
    
    vec3 a = v0_3 + (v1_3 - v0_3) * v;
    vec3 b = v1_3 + (v2_3 - v1_3) * v;
    vec3 c = a + (b - a) * v;

    vec3 t1 = vec3(cos(v0[0].w), 0.0, sin(v0[0].w));
    vec3 t0 = normalize(b - a);
    vec3 c0 = c - v2[0].w * t1;
    vec3 c1 = c + v2[0].w * t1;
    
   //float t = u + (0.5 * v) - (u * v);
   //float t = 0.5 + (u - 0.5) * (1 - (max((v - 0.5), 0)) / (1 - 0.5));
   //float t = (u - u * v * v);
   float t = 0.25 + (u - 0.25) * (u - u * v * v);
   
   out_pos = mix(c0, c1, t);
   out_nor = normalize(cross(t0, t1));

   gl_Position = camera.proj * camera.view * vec4(out_pos, 1.f); 
}
