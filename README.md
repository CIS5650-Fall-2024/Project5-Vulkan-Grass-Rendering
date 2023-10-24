# Vulkan Grass Rendering

![](img/renders/grass_wavy.gif)

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Aditya Gupta
  * [Website](http://adityag1.com/), [GitHub](https://github.com/AdityaGupta1), [LinkedIn](https://www.linkedin.com/in/aditya-gupta1/), [3D renders](https://www.instagram.com/sdojhaus/)
* Tested on: Windows 10, i7-10750H @ 2.60GHz 16GB, NVIDIA GeForce RTX 2070 8GB (personal laptop)
  * Compute capability: 7.5

## Introduction

This project implements a grass simulator and renderer using Vulkan, based on techniques described in the paper [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf). The project uses compute shaders to perform physics calculations on Bezier curves, which represent individual grass blades. To optimize performance, the compute shader also culls blades that aren't significantly visible. The visible blades are then processed in a graphics pipeline, employing a series of shaders for various stages, including a tessellation stage.

This README contains details about the specific features implemented, as well as performance analyses highlighting the efficiency of the rendering process.

## Features

### Spline tessellation and rendering

![](img/renders/grass_no_forces.png)

Using tessellation shaders, we can procedurally generate spline geometry for each grass blade. The paper offers multiple different ways to parametrize each blade's width; I opted for the parabola method to create varied but sharp shapes.

### Physical force simulation

![](img/renders/grass_wavy.gif)

Three forces affect the grass: recovery, gravity, and wind. Recovery pushes each blade's tip back to its original position with strength proportional to the distance between the two positions. Gravity is self-explanatory. Wind is implemented as an arbitrary force calculated using Perlin noise to create a wavy carpet-like effect.

### Culling

![](img/renders/grass_culling.gif)

To increase rendering performance, blades are culled by three tests. The first is that if a blade is parallel or close to parallel to the camera's view direction, it will be culled since it would barely show up anyway. The second is that blades outside the view frustum are culled since they wouldn't be visible at all regarldess. The third is that blades are culled with probability increasing as their distance from the camera decreases, as detail is less necessary in farther parts of the scene.

## Performance Analysis

For analysis, I used this camera angle:

![](img/renders/grass_closeup.png)

This allows all three culling methods to take effect as some blades are parallel to the camera, some blades are outside the frustum, and some blades are farther away than others.

### Number of blades

![](img/charts/num_blades.png)

As expected, performance drops as the number of blades increases. For the first couple sizes, there isn't a consistent difference between culling and no culling, likely because most of the rendering cost doesn't come from the grass blades themselves. However, as the grass blades increase in number, culling shows a clear improvement over no culling.

### Culling

![](img/charts/culling.png)

This chart shows the effect of each culling type on its own compared to no culling and all culling. Distance culling doesn't have much of an effect here since most of the blades are close to the camera, but it does offer a slight improvement. Frustum culling gave less of an improvement than I expected, but upon further consideration, I realized that most of the blades actually are in the frustum, so this makes sense. Lastly, orientation culling gives a surprisingly large performance boost. I didn't expect that as I thought there would be less blades parallel to the camera's view direction.