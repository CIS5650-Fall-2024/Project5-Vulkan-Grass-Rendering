#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// TODO: Declare tessellation evaluation shader inputs and outputs
layout (location = 0) in vec3 inV0[];
layout (location = 1) in vec3 inV1[];
layout (location = 2) in vec3 inV2[];
layout (location = 3) in vec3 in_dir_height_width[];

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    
    float angle = in_dir_height_width[0].x;
    vec3 t1 = vec3(cos(angle),0.0f,sin(angle));
    vec3 a = inV0[0]+v*(inV1[0]-inV0[0]);
    vec3 b = inV1[0]+v*(inV2[0]-inV1[0]);
    vec3 c = a+v*(b-a);
    vec3 c0 = c-t1*in_dir_height_width[0].z;
    vec3 c1 = c+t1*in_dir_height_width[0].z;
    //vec3 t0 = normalize(b-a);
    //vec3 n = normalize(cross(t0, t1));
    //float t = u;
    float t = u+0.5*v-u*v;
	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    gl_Position = vec4((1-t)*c0+t*c1,1.0f);
    gl_Position = camera.proj * camera.view * gl_Position;
}
