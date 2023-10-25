
#pragma once

#include <glm/glm.hpp>
#include "Device.h"

struct CameraBufferObject {
	glm::vec4 forward;//add
	glm::mat4 viewMatrix;
	glm::mat4 projectionMatrix;
};

class Camera {
private:
    Device* device;
    
    CameraBufferObject cameraBufferObject;
    
    VkBuffer buffer;
    VkDeviceMemory bufferMemory;

    void* mappedData;

    float r, theta, phi;
    glm::vec3 eye;
    glm::vec3 ref;
    glm::vec3 forward;
    glm::vec3 right;
    glm::vec3 up;
    glm::vec3 worldUp = glm::vec3(0,1, 0);

    void updateAttrb();
    glm::mat4 getViewMatrix();
public:
    Camera(Device* device, float aspectRatio);
    ~Camera();

    VkBuffer GetBuffer() const;
    
    void UpdateOrbit(float deltaX, float deltaY, float deltaZ);
    void UpdatePosition(float fwd, float rt);
};
