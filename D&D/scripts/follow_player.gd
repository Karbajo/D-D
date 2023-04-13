extends XRCamera3D

@export var current_character : Area3D
var offset = Vector3(0,3,3)


# Called when the node enters the scene tree for the first time.
func _ready():
	position = current_character.position + offset
	transform.rotated(Vector3(1,0,0),30)

func cambioTurno():
	current_character = Metadata.party_members[get_parent_node_3d().turno]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = current_character.position + offset
	transform.rotated(Vector3(1,0,0),30)
