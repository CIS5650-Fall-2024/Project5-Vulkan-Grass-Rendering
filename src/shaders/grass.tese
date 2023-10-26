#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    vec4 fwd;
    vec4 pos;
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
// v0: the position of the grass blade on the geomtry
// v1: a Bezier curve guide that is always "above" v0 with respect to the grass blade's up vector (explained soon)
// v2: a physical guide for which we simulate forces on
// v0.w holds orientation, v1.w holds height, v2.w holds width, and up.w holds the stiffness coefficient.
layout(location = 0) in vec4 inV0[];
layout(location = 1) in vec4 inV1[];
layout(location = 2) in vec4 inV2[];
layout(location = 3) in vec4 inUp[];

layout(location = 0) out vec3 color;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    vec3 v0 = inV0[0].xyz;
    vec3 v1 = inV1[0].xyz;
    vec3 v2 = inV2[0].xyz;

    float orientation = inV0[0].w;
    float width = inV2[0].w;
    float height = inV1[0].w;
    vec4 vertical = vec4(inUp[0].xyz,0.0);
    vec4 horizontal = vec4(sin(orientation), 0, cos(orientation), 0);//along width direction
    vec4 p0 = gl_in[0].gl_Position;//calculated by v0

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - width * horizontal.xyz;
    vec3 c1 = c + width * horizontal.xyz;
    vec3 t0 = normalize(b-a);
    vec3 norm = cross(t0,horizontal.xyz);
    float t = 
    //    u;//quad
    //    u + 0.5*v - u*v;//triangle
    //    u - u * v * v;//quadratic
        0.5 + (u - 0.5) * (1 - max(v - 0.4,0)/(1 - 0.4));//tip trig

    vec3 d = width * norm * (0.5 - abs(u - 0.5)*(1 - v));
    
    gl_Position = vec4(mix(c0,c1,t) + d,1);
    gl_Position = camera.proj * camera.view * gl_Position;
    color = mix(vec3(55.0/255, 77.0/255,34.0/255), vec3(95.0/255, 129.0/255,57.0/255), v);
}
