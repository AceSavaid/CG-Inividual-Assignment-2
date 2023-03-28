# CG-Inividual-Assignment-2
This is the 2nd individual project for computer graphics

## Task 1 - Create a repository for this assignment.
New Unity project created and its empty scene built
Unity Git Ignore was applied, the project was uploaded to github and the build was set as an initial release
![image](https://user-images.githubusercontent.com/69608587/228288800-05c72d48-4e46-41fa-bc52-0e2df3fc5967.png)


## Task 2 - Explain the difference between forward and deferred rendering using a diagram 
Forward Rendring - Lighting calculations are made in a single pass while rendering each game object
Defered Rendering - After Rendring the objects and their materials, the lighting calculations are then performed and lighting and shading is performed. 


## Task 3

Square waves made.  
![image](https://user-images.githubusercontent.com/69608587/228322062-8aeac6b5-a8a0-4922-8fe4-dae380accd44.png)
This was done by making a sine wave and then rounding the displacement to either 1 or -1 in vertex shader.  
![image](https://user-images.githubusercontent.com/69608587/228322420-072e5696-4c44-461a-b355-de3a099b4b0e.png)



# Task 4 Explaining the script




# Task 5


# Task 6 Explaing the Script pt 2
"Coloured Shadow" Changes the colour of the shadows casted on the object by itself and other objects.  
It takes in 3 properties, the colour and material of the object and then the colour that the shadows casted on the object should be. 
![image](https://user-images.githubusercontent.com/69608587/228305351-82b46bd8-1881-430e-a53f-05c9dec8701a.png)  
It takes in the shadow attenuation and then multiplies the inverse of the attenuation by the shadow colour. Anything not in a shadow takes in the colour and material and the light colour and uses that to determing the colour of the object in light.   
![image](https://user-images.githubusercontent.com/69608587/228314813-59d4934f-d7e5-436c-9cda-d1429c5f011c.png)  

This can be used to add more stylistic effects and colour palete to a game or object. 

# Task 7 - Explain a late game shader
## Self Casting Shadows 


