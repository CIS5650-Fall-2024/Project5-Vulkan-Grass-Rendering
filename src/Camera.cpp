#include <iostream>

#define GLM_FORCE_RADIANS
// Use Vulkan depth range of 0.0 to 1.0 instead of OpenGL
#define GLM_FORCE_DEPTH_ZERO_TO_ONE
#include <glm/gtc/matrix_transform.hpp>

#include "Camera.h"
#include "BufferUtils.h"

void Camera::updateAttrb()
{
    forward = glm::normalize(ref - eye);
    right = glm::cross(forward, worldUp);
    up = glm::cross(right, forward);
}

glm::mat4 Camera::getViewMatrix()
{
    glm::mat4 rot(glm::vec4(right,0), glm::vec4(up,0), glm::vec4(-forward,0), glm::vec4(0, 0, 0, 1));
    rot = glm::transpose(rot);
    glm::mat4 trans(glm::vec4(1,0,0,0), glm::vec4(0,1,0,0), glm::vec4(0,0,1,0), glm::vec4(-eye, 1));
    glm::mat4 res = rot * trans;
    return res;
}

Camera::Camera(Device* device, float aspectRatio) : device(device) {
    r = 10.0f;
    theta = 0.0f;
    phi = 0.0f;
    eye = glm::vec3(0, 1, r);
    ref = glm::vec3(0,1,0);
    updateAttrb();
    cameraBufferObject.viewMatrix = getViewMatrix();
    //glm::lookAt(glm::vec3(0.0f, 1.0f, 10.0f), glm::vec3(0.0f, 1.0f, 0.0f), glm::vec3(0.0f, 1.0f, 0.0f));
    cameraBufferObject.projectionMatrix = glm::perspective(glm::radians(45.0f), aspectRatio, 0.1f, 100.0f);
    cameraBufferObject.projectionMatrix[1][1] *= -1; // y-coordinate is flipped

    BufferUtils::CreateBuffer(device, sizeof(CameraBufferObject), VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT | VK_MEMORY_PROPERTY_HOST_COHERENT_BIT, buffer, bufferMemory);
    vkMapMemory(device->GetVkDevice(), bufferMemory, 0, sizeof(CameraBufferObject), 0, &mappedData);
    memcpy(mappedData, &cameraBufferObject, sizeof(CameraBufferObject));
}

VkBuffer Camera::GetBuffer() const {
    return buffer;
}

void Camera::UpdateOrbit(float deltaX, float deltaY, float deltaZ) {
    theta += deltaX;
    phi += deltaY;
    r = glm::clamp(r - deltaZ, 1.0f, 50.0f);

    float radTheta = glm::radians(theta);
    float radPhi = glm::radians(phi);

    //glm::mat4 rotation = glm::rotate(glm::mat4(1.0f), radTheta, glm::vec3(0.0f, 1.0f, 0.0f)) * glm::rotate(glm::mat4(1.0f), radPhi, glm::vec3(1.0f, 0.0f, 0.0f));
    //glm::mat4 finalTransform = glm::translate(glm::mat4(1.0f), glm::vec3(0.0f))
    //    * rotation 
    //    * glm::translate(glm::mat4(1.0f), glm::vec3(0.0f, 1.0f, r));
    float cosPhi = glm::cos(radPhi);
    float sinPhi = glm::sin(radPhi);
    float sinTheta = glm::sin(radTheta);
    float cosTheta = glm::cos(radTheta);
    eye = ref - glm::vec3(cosPhi * sinTheta, sinPhi, cosPhi * cosTheta) * r;
    updateAttrb();
    cameraBufferObject.viewMatrix = getViewMatrix();//glm::inverse(finalTransform);

    memcpy(mappedData, &cameraBufferObject, sizeof(CameraBufferObject));
}

void Camera::UpdatePosition(float fwd, float rt)
{
    glm::vec3 diff = glm::normalize(glm::vec3(forward.x, 0, forward.z)) * fwd + glm::normalize(glm::vec3(right.x, 0, right.z))*rt;
    eye += diff;
    ref += diff;

    cameraBufferObject.viewMatrix = getViewMatrix();//glm::inverse(finalTransform);

    memcpy(mappedData, &cameraBufferObject, sizeof(CameraBufferObject));
}

Camera::~Camera() {
  vkUnmapMemory(device->GetVkDevice(), bufferMemory);
  vkDestroyBuffer(device->GetVkDevice(), buffer, nullptr);
  vkFreeMemory(device->GetVkDevice(), bufferMemory, nullptr);
}
