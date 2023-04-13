extends XRCamera3D

@export var current_character : Area3D
var offset = Vector3(0,3,3)
var smooth_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	position = current_character.position + offset
	transform.rotated(Vector3(1,0,0),30)

func change_turn():
	current_character = Metadata.party_members[get_parent_node_3d().turn]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin = lerp(transform.origin, current_character.position + offset, smooth_speed * delta)
	transform.rotated(Vector3(1,0,0),30)
