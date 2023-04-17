extends XRCamera3D

@export var current_character : Area3D
var offset = Vector3(0,3,3)
var rotation_axis = Vector3(1,0,0)
var smooth_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	position = current_character.position + offset

func change_turn():
	current_character = Metadata.party_members[Metadata.turn]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin = lerp(transform.origin, current_character.position + offset, smooth_speed * delta)
#	check_input()
#
#func check_input():
#	if Input.is_action_just_pressed("left_rotation"):
#		transform = transform.rotated(Vector3(0,1,0), -PI/2)
#		offset += Vector3(-3,0,-3)

