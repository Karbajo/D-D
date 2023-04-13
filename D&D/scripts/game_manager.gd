extends Node3D

var turno = 0

@export var characters : Array[Area3D] 

# Called when the node enters the scene tree for the first time.
func _ready():

	for i in characters:
		print(i)
		
	iniciativa()

func cambioTurno():
	if turno < Metadata.getPlayersSize()-1:
		turno +=1
	else :
		turno=0
	
	get_node("XRCamera3D").cambioTurno()

func iniciativa():
	for i in Metadata.party_members:
		Metadata.party_members[i].order = i
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
