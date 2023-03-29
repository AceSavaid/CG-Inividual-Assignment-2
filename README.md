# CG-Inividual-Assignment-2
This is the 2nd individual project for computer graphics

## Task 1 - Create a repository for this assignment.
New Unity project created and its empty scene built
Unity Git Ignore was applied, the project was uploaded to github and the build was set as an initial release
![image](https://user-images.githubusercontent.com/69608587/228288800-05c72d48-4e46-41fa-bc52-0e2df3fc5967.png)


## Task 2 - Explain the difference between forward and deferred rendering using a diagram 
Forward Rendring - Lighting calculations are made in a single pass while rendering each game object, therefore this process is done each time for each lighting sorce in the scene individually.  This causes limitations to how shadows of these collective light sources are formed.  
![Screenshot 2023-03-28 233908](https://user-images.githubusercontent.com/69608587/228422201-fa3c3537-a2c9-43f2-8e11-8e5a7c8db354.png)
![image](https://user-images.githubusercontent.com/69608587/228627913-922fb248-d88c-41a4-874c-8d9efd7a8053.png)


Defered Rendering - After Rendring the objects and their materials, the lighting calculations are then performed and lighting and shading is performed.  This allows for more light sources to me used.  
![Screenshot 2023-03-28 234639](https://user-images.githubusercontent.com/69608587/228422320-b1e07af7-2b76-413e-99cc-3a4ad6267e78.png)
![image](https://user-images.githubusercontent.com/69608587/228629166-c4226187-ce5a-45b4-935c-a7c212885f83.png)


The main difference between froward and deferred rendering as seen in the diagrams is that in deferred rendering, the results of the geometry and fragment shader are passed to the G Buffer.  This stores information like colours, normals and the depths of objects.  The lighting is then calculates as geometry and calculations are made between that and the information in the G Buffer.  
For example, if a scene have several objects with a directional light and point lights scattered around the scene, the G buffer will gather the information of the objects and then it will calculate the light as geometries (for example point lights are calculated a spheres) and then tested against the information of objects and their depths and normals to then cast these lights against them. 


## Task 3

Square waves made.  
![image](https://user-images.githubusercontent.com/69608587/228322062-8aeac6b5-a8a0-4922-8fe4-dae380accd44.png)
This was done by making a sine wave and then rounding the displacement to either 1 or -1 in vertex shader.  
![image](https://user-images.githubusercontent.com/69608587/228322420-072e5696-4c44-461a-b355-de3a099b4b0e.png)

To perform movement a time variable was applied to the sine wave and another variable was added so that it could be togglable in process.
![image](https://user-images.githubusercontent.com/69608587/228428271-f8e29015-60c3-4ace-93ae-7f1652df7468.png)

For toon shading shading, I had to convert the shader from a vertex and fragment shader to a surface shader and then apply toonshading to it. 


# Task 4 Explaining the script
This script is used for rendering post processing effects onto the camera.  This can be told from the "void OnRenderImage" which is a camera/rendering function. It is upsampling the image by deviding the screen into several subsections and then using the information gathered to render the image in more detail but also causes blur. 



# Task 5
## Outlining
This uses the normals and vertecies of a shader to create an additional layer of the object that can be coloured and thickened to create an outline effect.  This usues a pass so that it can perform operations on the object and material more than once.  To get the intended look, this pass needs to be done before the regular rendering of the object, as well as not use the Z buffer as this will allow what is rendered after it to always be infront of the outline effect. To add to this shader, the outline thickness and colour are togglable and a texture can be added. 

## Vertex Extrusion
Using displacement maping to extude and intrude the vertecies.  This takes in a displacement map which is a greyscaled image and uses that to determine how much vertex will be moved/displaced from its origin.  To add to this shaders, another level of scaling the displacement was added in addition to being able to add both a material and colouring to the material.  
![image](https://user-images.githubusercontent.com/69608587/228680050-5fadfec6-c997-42e4-8211-7384ea5c5858.png)
![image](https://user-images.githubusercontent.com/69608587/228681485-f2318d38-1f14-4c25-803e-61e76d409efa.png)




# Task 6 Explaing the Script pt 2
"Coloured Shadow" Changes the colour of the shadows casted on the object by itself and other objects.  
It takes in 3 properties, the colour and material of the object and then the colour that the shadows casted on the object should be. 
![image](https://user-images.githubusercontent.com/69608587/228305351-82b46bd8-1881-430e-a53f-05c9dec8701a.png)  
It takes in the shadow attenuation and then multiplies the inverse of the attenuation by the shadow colour. Anything not in a shadow takes in the colour and material and the light colour and uses that to determing the colour of the object in light.   
![image](https://user-images.githubusercontent.com/69608587/228314813-59d4934f-d7e5-436c-9cda-d1429c5f011c.png)  

This can be used to add more stylistic effects and colour palete to a game or object. 

# Task 7 - Explain a late game shader
## Glass 


