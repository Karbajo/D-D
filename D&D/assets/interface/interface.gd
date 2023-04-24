extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextEdit.text = get_parent().to_string() + "\n" + "N. accion: " + str(get_parent().actions)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#Se que esto está regular hecho, pero es algo temporal
	if Controller.get_actual_player() == get_parent():
		visible = true
	else:
		visible = false
	$TextEdit.text = get_parent().to_string() + "\n" + "N. accion: " + str(get_parent().actions)

func _on_button_pressed():
	Controller.get_actual_player().check_actions()
