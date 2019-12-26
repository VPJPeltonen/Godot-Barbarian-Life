extends Sprite

#script for randomizing appearance of objects

export(Resource) var sprite1
export(Resource) var sprite2
export(Resource) var sprite3

export var sprites = 2
export var random_rotation = false

var type = "normal"

# enter tree function instead of ready so shadow can get the correct sprite
func _enter_tree():
	var rng = RandomNumberGenerator.new()
	rng.randomize( )
	var num = rng.randi_range(1,sprites)
	match num:
		1:
			set_texture(sprite1)
		2:
			set_texture(sprite2)
		3:
			set_texture(sprite3)
	if random_rotation:
		rotation = rng.randf_range(0,2*PI)

func change_color(new_color):
	modulate = new_color