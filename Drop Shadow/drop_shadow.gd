extends Sprite

#script for showing shadows without killing the performance on phone

var x_offset
var y_offset
var lights 
var closest

func _ready():
	create_shadow()
	lights = get_tree().get_nodes_in_group("light_sources")# find light sources
	closest = get_closest_light(lights)
	move_shadow()

func move_shadow():
	if lights.size() != 0:
		# get its direction
		var lightY = closest.get_global_position().y 
		var lightX = closest.get_global_position().x
		var y_difference = get_global_position().y-lightY
		var x_difference = get_global_position().x-lightX
		# set offset
		var difference = abs(y_difference)+abs(x_difference)
		x_offset = (abs(x_difference)/difference)*20
		y_offset = (abs(y_difference)/difference)*20
		if x_difference <= 0: 
			global_position.x = get_parent().global_position.x - x_offset
		else:
			global_position.x = get_parent().global_position.x + x_offset
		if y_difference < 0:
			global_position.y = get_parent().global_position.y - y_offset
		else:
			global_position.y = get_parent().global_position.y + y_offset	

func get_closest_light(lights):
	var light_distance
	var closest
	for light in lights:
		var temp_light_distance = get_global_position().distance_squared_to(light.get_global_position())
		if light_distance == null:
			closest = light
			light_distance = temp_light_distance
		if abs(temp_light_distance) < abs(light_distance):
			closest = light
			light_distance = temp_light_distance
	return closest

func create_shadow():
	modulate = Color(0,0,0,0.5)#make black
	# get parents sprite and copy it
	var sprite = get_parent().get_texture()
	set_texture(sprite)