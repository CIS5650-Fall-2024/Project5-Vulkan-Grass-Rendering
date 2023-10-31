# Vulkan Grass Rendering

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Tong Hu
* Tested on: Windows 11, Ryzen 7 1700X @ 3.4GHz, 16GB RAM, NVIDIA RTX 2060 6GB (Personal Desktop)

## Summary

![Demo GIF](#)

This project is a Vulkan-based application designed to render realistic grass with an integrated physics simulation, utilizing compute shaders. The implementation is inspired by the techniques described in the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).

## Simulation Details

The physical simulation of grass in this project models each blade as an individual entity, influenced by three primary forces:

1. **Gravity**: Bends the grass blades downward.
2. **Recovery**: Acts against gravity, helping the blades maintain their upright position.
3. **Wind**: Varies based on location and time, adding dynamic movement to the grass.

Each grass blade is geometrically represented by a Bezier curve, composed of multiple control points.

![Blade Definition](./img/blade_model.jpg)

## Features

### Forces Simulation

This application simulates the effects of gravity, recovery, and wind on grass blades. Below are visual demonstrations of these simulations:

#### Gravity Effect

|  Original (No Force) | Gravity Only |
|:--------------------:|:-------------:|
| ![No Force Pic](#)   | ![Gravity Pic](#) |

#### Comprehensive Forces

| Gravity & Recovery | Gravity, Recovery & Wind |
|:------------------:|:-------------------------:|
| ![Recovery Pic](#) | ![Wind GIF](#)           |

### Culling Optimization

To enhance performance and minimize the number of grass blades rendered, the application employs three types of culling:

1. **Orientation Test**: Determines visibility based on the blade’s orientation relative to the camera.
2. **View-Frustum Test**: Ensures only blades within the camera’s field of view are rendered.
3. **Distance Test**: Reduces detail for distant blades, saving computational resources.

#### Culling Demonstrations

##### Orientation Test

|  Original (No Culling) | Orientation Test |
|:------------------:|:------------:|
|  ![Original GIF](#)  | ![Orien Test](#) |

##### View-Frustum and Distance Tests

|  View-Frustum Test | Distance Test |
|:------------------:|:------------:|
|  ![VF Test](#)  | ![Distance GIF](#) |

## Performance Analysis

### Impact of Grass Blade Quantity

The quantity of grass blades significantly affects rendering performance. Below is an analysis of Frames Per Second (FPS) against various blade counts.

![FPS vs #Blades](#)

### Efficiency of Culling Techniques

Culling helps in reducing the rendering workload by limiting the number of grass blades processed.

![FPS vs Culling Methods](#)
