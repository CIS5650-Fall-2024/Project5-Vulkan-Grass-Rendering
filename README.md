Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 5**

* Licheng CAO
  * [LinkedIn](https://www.linkedin.com/in/licheng-cao-6a523524b/)
* Tested on: Windows 10, i7-10870H @ 2.20GHz 32GB, GTX 3060 6009MB

Result
====
 * This project is implemented based on [Responsive Real-Time Grass Rendering for General 3D Scenes](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf).
<p align="center">
    <img src="mdassets/result.gif">
</p>

Features
===
### Blade Geometry
 * The [paper](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf) illustrated 4 kinds of blade shapes as shown. I picked triangle-tip as my basic blade geometry.
<p align="center">
    <img src="mdassets/geom.PNG">
</p>

### Force Simulation
 * In the [paper](https://www.cg.tuwien.ac.at/research/publications/2017/JAHRMANN-2017-RRTG/JAHRMANN-2017-RRTG-draft.pdf), authors created a physical model to simulate grass as shown below. According to the paper, the parameter needed to simulate grass includes `v0`, `v1`, `v2`, `up`, `height`, `direction`, `width`, `stiffness`. Since the first 4 values are `vec3` and the following values are simply `float`, my implementation passed 4 `vec4`s to the shader by storing the `float` value into `vec4.w`. In this application, 3 kinds of forces are simulated, which are `gravity`, `wind force` and `recover force`. The `recover force` describes the force that brings grass blade back into equilibrium and is calculated with `stiffness`.
 <p align="center">
    <img src="mdassets/phy.PNG">
</p>

### Culling
* To improve performance, the paper also introduced several culling methods to remove uneccessary blades to reduce the overall shapes rendered.

|Orientation Culling|Frustum Culling|Distance Culling|
|:--:|:--:|:--:|
|<img src="mdassets/oriCull.gif" width="200">|<img src="mdassets/frusCull.gif" width="200">|<img src="mdassets/distCull.gif" width="200">|

Performance
===
 * As expected the average fps descreases as the number of blades increases. However, as we can see in the figure, the fps remains nearly the same when the number of blades is under 2^13, which indicates the efficiency of the algorithm.
  <p align="center">
    <img src="mdassets/fpsnum.PNG">
</p>

* I recorded the average fps with 2^18 blades, and the result is shown below. The average fps indicates that all culling methods offer some improvement for rendering. With my test scene, the distance culling contributes the most to fps, the reason might be that I picked a relatively small max distance for culling test, so that many blades are culled. Frustum culling gives the least improvement, this may due to the fact that I tried to record every blades in the output so most blades fall in the frustum and therefore are not culled.

|culling method applied|all cullings|orientation culling|frustum culling|distance culling|none|
|:--:|:--:|:--:|:--:|:--:|:--:|
|average fps(higher better)|150.5|94.1|79.7|98.4|65.3|
  <p align="center">
    <img src="mdassets/fpscull.PNG">
</p>