extends Node3D

@onready var characters = [$Character, $Character2]

# Called when the node enters the scene tree for the first time.
func _ready():
	var character_index = 0
	for i in characters:
		Metadata.party_members[character_index] = i
		character_index += 1
		
	iniciative()

func change_turn():
	if Metadata.turn < Metadata.get_players_size()-1:
		Metadata.turn += 1
	else :
		Metadata.turn = 0
	
	get_node("XRCamera3D").change_turn()

func iniciative():
	for i in Metadata.party_members:
		Metadata.party_members[i].order = i

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
