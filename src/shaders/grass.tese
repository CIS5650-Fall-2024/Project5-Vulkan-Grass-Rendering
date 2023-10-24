#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
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

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

	// TODO: Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    float orientation = inV0[0].w;
    float width = inV2[0].w;
    vec4 vertical = vec4(inUp[0].xyz,0.0) * inV1[0].w;

    vec4 horizontal = vec4(sin(orientation), cos(orientation), 0, 0) * width;
    vec4 p0 = gl_in[0].gl_Position;
    gl_Position =  p0 + horizontal * u + v * vertical;
    gl_Position = camera.proj * camera.view * gl_Position;
}
