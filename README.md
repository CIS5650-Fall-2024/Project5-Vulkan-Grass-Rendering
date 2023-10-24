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

### Physical force simulation

![](img/renders/grass_wavy.gif)

### Culling

![](img/renders/grass_culling.gif)

## Performance Analysis

### Number of blades

### Culling
