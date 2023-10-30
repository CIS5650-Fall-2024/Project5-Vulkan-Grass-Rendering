#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs

layout(location = 0) in vec4[] v0;
layout(location = 1) in vec4[] v1;
layout(location = 2) in vec4[] v2;
layout(location = 3) in vec4[] up;


layout(location = 0) out vec3 normal;



void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    // From geom part of the papger

    vec3 new_v0 = vec3(v0[0]);
    vec3 new_v1 = vec3(v1[0]);
    vec3 new_v2 = vec3(v2[0]);
    vec3 new_up = vec3(up[0]);
    float w = v2[0].w;
    float angle = v0[0].w;

    //vec3 forward = cross(up,vec3(sin(angle),0.0,cos(angle)));
  
    vec3 a = new_v0 + v * (new_v1 - new_v0);
    vec3 b = new_v1 + v * (new_v2 - new_v1);
    vec3 c = a + v * (b - a);



    vec3 t1 = normalize(vec3(cos(angle),0.0,sin(angle)));
    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;

    vec3 t0 = normalize(b - a);
    normal = normalize(cross(t0, t1));

    float t = u + 0.5 * v - u * v; 
    vec3 position = (1 - t) * c0 + t * c1;
    vec4 new_position = vec4(position, 1);

    gl_Position = camera.proj * camera.view * new_position;


	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
}
