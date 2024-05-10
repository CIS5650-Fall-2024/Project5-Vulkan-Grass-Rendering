#version 450
#extension GL_ARB_separate_shader_objects : enable

// Tessellation Evaluation Shader
// https://www.khronos.org/opengl/wiki/Tessellation#Tessellation_primitive_generation

layout(quads, equal_spacing, ccw) in; // We are using quad patches,
                                      // so tessellation levels are applied to 
                                      // 2 inner edges and 4 outer edges of the quad.

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation evaluation shader inputs and outputs
layout(location = 0) in vec4 in_V0[];
layout(location = 1) in vec4 in_V1[];
layout(location = 2) in vec4 in_V2[];

layout(location = 0) out float fs_V;
layout(location = 1) out vec3 fs_Nor;

void main() {
    // Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;
    
    // Since the layout in TCS generated only one blade per patch, see how the number of elements
    // in each array input is just one and can be accessed directly at index 0
    vec3 v0 = in_V0[0].xyz;
    vec3 v1 = in_V1[0].xyz;
    vec3 v2 = in_V2[0].xyz;

    float orient = in_V0[0].w;
    float width = in_V2[0].w;
    
    // Blade geometry based off De Casteljau's algo
    vec3 a = mix(v0, v1, v); // auxiliary
    vec3 b = mix(v1, v2, v); // auxiliary
    vec3 c = mix(a, b, v);   // curve point
    
    vec3 t0 = normalize(b - a); // tangent
    vec3 t1 = normalize(vec3(-cos(orient), 0.0, sin(orient))); // bitangent from the direction vector along the width of the blade

    vec3 c0 = c - width * t1;
    vec3 c1 = c + width * t1;

    float t = u + 0.5 * v - u * v; // triangle shape's interp param
    vec3 pos = mix(c0, c1, t);
    
    // outputs
    fs_V = v;
    fs_Nor = normalize(cross(t0, t1));

    gl_Position = camera.proj * camera.view * vec4(pos, 1.0); // in clip space
}
