Vulkan Grass Rendering
==================================

**University of Pennsylvania, CIS 565: GPU Programming and Architecture, Project 3**

* Saksham Nagpal  
  * [LinkedIn](https://www.linkedin.com/in/nagpalsaksham/)
* Tested on: Windows 11 Home, AMD Ryzen 7 6800H Radeon @ 3.2GHz 16GB, NVIDIA GeForce RTX 3050 Ti Laptop GPU 4096MB

## Representative Outcome

![](captures/finalrender.gif)
***<center>2<sup>15</sup> grass blades, tesselation level = 8</center>***

## Performance Analysis
In this section, we first consider the effect of the various culling methods implemented and the corresponding FPS gains yielded by them, if any. Further, we compare the performance at varying number of grass blades and how it is affected by the culling methods.

### 1. Culling Methods
<img src="captures/perfan1.png" width=500>

*<center>All tests performed for 2<sup>15</sup> grass blades, tesselation level = 8</center>*

For the considered blade count and geometry, orientation and distance culling seems to give a better FPS boost than frustum culling. In fact, frustum culling's performance is almost at-par with the no-culling test, with the minimal FPS boost probably being a result of the chosen camera angle such that some blades actually ended up getting culled. Had no blade been culled, frustum culling would've resulted in the same or perhaps poorer performance than having no culling at all. Finally, the best case scenario turns out to be when all 3 culling modes are enabled. This is expected as that scenario would result in the maximum number of blades getting culled.

### 2. Number of Grass Blades
<img src="captures/perfan2_1.png" width=500>

*<center>All tests performed at tesselation level = 8</center>*

The above graph depicts the resultant FPS as the number of blades in the scene is varied. The overall decrease in FPS with increasing number of blades is expected. However, in each scenario, it is interesting to note the performance both with all 3 cuulling modes `ON` and `OFF`. The following plot highlights this difference better:

<img src="captures/perfan2_2.png" width=500>

We see that as the number of blades in the scene increases, the culling scenario becomes more performant than having no culling in the scene. However this difference in gain is lower when there are fewer blades in the scene, with the no culling mode even being more performant than enabling all 3 culling mode when number of blades is 2<sup>10</sup>. This is perhaps because there are very few blades in the scene, and mostly none of them get culled. Hence the cost of computations performed for the culling tests is not able to offset the cost of processing limited geometry in the scene.