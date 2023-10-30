Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Tianyi Xiao
  * [LinkedIn](https://www.linkedin.com/in/tianyi-xiao-20268524a/), [personal website](https://jackxty.github.io/), [Github](https://github.com/JackXTY).
* Tested on: Windows 11, i9-12900H @ 2.50GHz 16GB, Nvidia Geforce RTX 3070 Ti 8032MB (Personal Laptop)

### Description

In this project, I use Vulkan to implement a grass simulator and renderer. The culling and wind deformation is calculated in compute shader, and the interpolation is done in tessellation shader to get the acurate grass blade shape from Bezier curve dynamically.

Fianl Result:
![](/img/grass_wind.gif)

### Implementation Stages

First, with tessellation, we can get static grass with correct shape.
![](/img/1-tessellation.png)

Then, the wind force function is implemented in compute shader, which bend the grass.
![](/img/2-wind.png)

Then, unnecessary grass baldes are culled out with three cull test.

Orientation Test:  Cull grass baldes that nearly parpendicular to camera.
![](/img/2_orientation_test.gif)

View frustrum Test:  Cull grass blades that outside the view frustrum.

(There are grass showed up on the edge of view frustrum.)
![](/img/3_view_test.gif)
![](/img/3_view_test_2.gif)

View frustrum Test:  Cull grass blades according to distance. A further grass blade has higher chance to be culled out.
![](/img/4_distance_test.gif)

### Analysis

average time of each frame 0.0166s (about 60 fps)