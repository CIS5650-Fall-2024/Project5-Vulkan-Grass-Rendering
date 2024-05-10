
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

// Declare vertex shader inputs and outputs
layout(location = 0) in vec4 in_V0;
layout(location = 1) in vec4 in_V1;
layout(location = 2) in vec4 in_V2;

layout(location = 0) out vec4 out_V0;
layout(location = 1) out vec4 out_V1;
layout(location = 2) out vec4 out_V2;

out gl_PerVertex {
    vec4 gl_Position;
};

vec4 multiply(mat4 m, vec4 v) {
    vec4 result = m * vec4(v.xyz, 1.0);
    result.w = v.w; // preserve the original w bc it contains additional info like orient, width, stiffness etc which will be required in evaluation shader
    return result;
}

void main() {
    //Note we are NOT transforming into screen space bc we will have to use world space pos for positioning tessellated points later in evaluation shader
    
    out_V0 = multiply(model, in_V0);
    out_V1 = multiply(model, in_V1);
    out_V2 = multiply(model, in_V2);

	gl_Position = out_V0;
}
