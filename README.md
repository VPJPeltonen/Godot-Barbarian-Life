# Godot-Barbarian-Life
Godot scripts and nodes for android game Barbarian Life. Made for Godot 3.1. Currently there is just a playable web version at https://substandardshrimp.itch.io/barbarian-life

## Drop Shadow
Script for showing simple drop shadows for furniture and characters without killing the performance on phone. 
### Use
Just add the node as child of a sprite or animated sprite you want to create shadow for. For animated sprites in needs to have static toggled off and has to have animation named "walk". The animation name can be easily changed in code based on your animations. For it to work you have to add all your light sources to "light_sources" group

![](Examples/shadow_example.gif)

## Random Sprite
Script to attach to furniture to give them random appearance and rotation. Good for placing stuff to make them look more natural fast
### Use
Add to object you want to randomize. Select on the UI if you want random rotation and how many variations you have of the sprite. Add the sprites to the script in UI you want to use. You only have to add the amount of sprites you have selected. Maximum variations is 3 but it should be easy to increase that.