#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout(location=0) in vec4 v0[];
layout(location=1) in vec4 v1[];
layout(location=2) in vec4 v2[];
layout(location=3) in vec4 v3[];

layout(location = 0) out vec3 out_normal;
layout(location = 1) out vec3 out_pos;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    
    vec3 ver0=v0[0].xyz;
    vec3 ver1=v1[0].xyz;
    vec3 ver2=v2[0].xyz;
    vec3 up=v3[0].xyz;
    float orit = v0[0].w;
    float w = v2[0].w;
    
    vec3 t1=vec3(cos(orit), 0, sin(orit));
    vec3 a = mix(ver0, ver1, v);
    vec3 b = mix(ver1, ver2, v);
    vec3 c = mix(a, b, v);
    vec3 c0=c-w*t1;
    vec3 c1=c+w*t1;
    vec3 t0=normalize(b-a);

    out_pos=t0;
    out_normal=normalize(cross(t0,t1));

    float t = u + 0.5 * v - u * v;
    vec3 pos=mix(c0,c1,t);
    gl_Position = camera.proj * camera.view * vec4(pos,1.0f);
}
