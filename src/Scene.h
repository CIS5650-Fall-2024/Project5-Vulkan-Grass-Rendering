#pragma once

#include <glm/glm.hpp>
#include <chrono>

#include "Model.h"
#include "Blades.h"

using namespace std::chrono;

struct Time {
    float deltaTime = 0.0f;
    float totalTime = 0.0f;
};

class Scene {
private:
    Device* device;
    
    VkBuffer timeBuffer;
    VkDeviceMemory timeBufferMemory;
    Time time;
    float fps_arr[100] = { 0 };
    int fps_arr_idx = 0;
    float fps_sum = 0;
    
    void* mappedData;

    std::vector<Model*> models;
    std::vector<Blades*> blades;

high_resolution_clock::time_point startTime = high_resolution_clock::now();

public:
    Scene() = delete;
    Scene(Device* device);
    ~Scene();

    const std::vector<Model*>& GetModels() const;
    const std::vector<Blades*>& GetBlades() const;
    
    void AddModel(Model* model);
    void AddBlades(Blades* blades);

    VkBuffer GetTimeBuffer() const;

    void UpdateTime();
};
