Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Linda Zhu: [Linkedin](https://www.linkedin.com/in/lindadaism/)
* Tested on: Windows 11, i7-12800H @ 2.40GHz 16GB, NVIDIA GeForce RTX 3070 Ti (Personal Laptop)

## Overview

In this project, I use Vulkan to implement a grass simulator and renderer. I use tessellation shaders to perform physics calculations on Bezier curves that represent individual grass blades. To add an organic look to the grass field, I use the compute shader to apply three types of natural forces, namely environmental gravity, wind, and self-recovery, to the blades. Since rendering every single blade on every frame is fairly inefficient, I also use the compute shader to cull grass blades that don't contribute to a given frame. The remaining blades are then passed to a graphics pipeline.You will write a vertex shader to transform Bezier control points, tessellation shaders to dynamically create the grass geometry from the Bezier curves, and a fragment shader to shade the grass blades.

The base code provided includes all of the basic Vulkan setup, including a compute pipeline that will run your compute shaders and two graphics pipelines, one for rendering the geometry that grass will be placed on and the other for rendering the grass itself. Your job will be to write the shaders for the grass graphics pipeline and the compute pipeline, as well as binding any resources (descriptors) you may need to accomplish the tasks described in this assignment.

## Tessellation

 Original quad patch | Remapped patch |
|---|---
![](/img/results/quadPatch.png) | ![](/img/results/remappedPatch.png)

First grass blade:

![](/img/results/firstBlade.png)

And (drum roll...) lush grass!

![](/img/results/lushGrass.png)

## Natural Forces
### Gravity
### Wind
### Recovery
### Under All Forces
![](/img/results/underAllForces.gif)

## Optimization: Culling
Based on blade orientation, blade's relative position with respect to camera's view-frustum and blade's distance from the camera.

### Orientation
![](/img/results/orientCulling.gif)

### View-Frustum
![](/img/results/frustumCulling.gif)

### Distance
![](/img/results/distCulling.gif)