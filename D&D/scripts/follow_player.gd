extends XRCamera3D

@export var current_character : Area3D
var offset = [Vector3(0,3,3), Vector3(-3,3,0), Vector3(0,3,-3), Vector3(3,3,0)]
var current_offset = 0

var rotation_axis = Vector3(1,0,0)
var smooth_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	position = current_character.position + offset[current_offset]

func change_turn():
	current_character = Controller.get_actual_player()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin = lerp(transform.origin, current_character.position + offset[current_offset], smooth_speed * delta)


