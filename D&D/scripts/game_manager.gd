extends Node3D

@onready var characters = [$Character, $Character2]
@onready var enemies = [$Enemie]
@onready var camera = $XRCamera3D

# Called when the node enters the scene tree for the first time.
func _ready():
	var character_index = 0
	for i in characters:
		Controller.party_members[character_index] = i
		character_index += 1
	
	Controller.initialize_character_inventory()
	iniciative()

func change_turn():
	if Controller.turn < Controller.get_players_size()-1:
		Controller.turn += 1
	else :
		Controller.turn = 0
	
	get_node("XRCamera3D").change_turn()

func iniciative():
	for i in Controller.party_members:
		Controller.party_members[i].order = i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	check_input()

func check_input():
	if Input.is_action_just_pressed("left_rotation"):
		camera.transform = camera.transform.rotated(Vector3(0,1,0), -PI/2)
		camera.current_offset = (camera.current_offset + 1) % 4 
		
#		for character in characters:
#			character.rotation = Vector3(-PI/180,0,0)
