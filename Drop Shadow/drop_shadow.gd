extends Sprite

#script for showing shadows without killing the performance on phone

export var static = true 	#will the shadow be calculated more than once, is the object moving
export var height = 2 		#changes the scale of the offset. Doesnt really work that well

var lights 
var closest
var second_closest

func _ready():
	
	if !static:		#start timer if light sources need to be recalculated
		$timer.start()
	lights = get_tree().get_nodes_in_group("light_sources")		#find light sources in the map
	create_shadow()
	get_closest_lights()
	move_shadow()

func _process(delta):
	if !static:
		move_shadow()

func move_shadow():				#move the shadow based on lights	
	if lights.size() != 0:		# if no lights no reason to move
		var difference = global_position.distance_to(closest.global_position)
		modify_shadow(difference)
		set_shadow_offset(difference)

#adjust the shadow size and alpha 		
func modify_shadow(dif):
	var shadow_strength
	if second_closest != null:		#Adjust the alpha based on relative distance of two closest lights.
		shadow_strength = 1-(dif/global_position.distance_to(second_closest.global_position))
	else:							#if there is only one light just change the alpha based on distance to it. 
		shadow_strength = (1000-dif)/1000
	shadow_strength = clamp(shadow_strength,0.01,0.9)
	modulate = Color(0,0,0,shadow_strength)
	var shadow_scale = 1+((1-shadow_strength)/2)
	scale = Vector2(shadow_scale,shadow_scale)

func set_shadow_offset(difference):		#moves the shadow to opposite side from the main light source
	var y_difference = get_global_position().y-closest.get_global_position().y
	var x_difference = get_global_position().x-closest.get_global_position().x
	var x_offset = (abs(x_difference)/difference)*(height*12)
	var y_offset = (abs(y_difference)/difference)*(height*12)
	if x_difference <= 0: 
		global_position.x = get_parent().global_position.x - x_offset
	else:
		global_position.x = get_parent().global_position.x + x_offset
	if y_difference <= 0:
		global_position.y = get_parent().global_position.y - y_offset
	else:
		global_position.y = get_parent().global_position.y + y_offset
		
func get_closest_lights():	
	closest = compare_distance(null)
	second_closest = compare_distance(closest)

func compare_distance(used):
	var light_distance
	var closest
	for light in lights:
		if light != used:	#checks if the light being checked is already the closes light. On finding closest light null is passed so no light will be skipped
			var temp_light_distance = get_global_position().distance_squared_to(light.get_global_position())
			if light_distance == null:
				closest = light
				light_distance = temp_light_distance
			if abs(temp_light_distance) < abs(light_distance):
				closest = light
				light_distance = temp_light_distance
	return closest

func create_shadow():
	modulate = Color(0,0,0,0.5)
	if static:
		var sprite = get_parent().get_texture()		# Copies the texture of parent. Only works for sprites
		set_texture(sprite)
	else:
		var sprite = get_parent().get_sprite_frames().get_frame("walk",1)	# Gets the sprite of second frame of my characters walk animation. Works for animated sprites   
		set_texture(sprite)

func _on_timer_timeout():
	get_closest_lights() 