extends Area3D

######################################################################
# Variables ##########################################################
######################################################################

# Movement ###########################################################
var tile_size = 1
var inputs   = {"right"  : Vector3.RIGHT,
				"left"   : Vector3.LEFT,
				"forward": Vector3.FORWARD,
				"back"   : Vector3.BACK}

@onready var ray = $CollisionRay

var animation_speed = 4
var moving          = false

# Stats ##############################################################
@export var max_steps   : int
@export var max_actions : int
@export var bag_size    : int
@export var max_health  : int
@export var max_mana    : int
@export var armor       : int

var health  = max_health
var mana    = max_mana 
var steps   = 0
var actions = 0

######################################################################
# Code ###############################################################
######################################################################
func _ready():
	position = position.snapped(Vector3(1,0.3,1) * tile_size)
	position += Vector3(1,0.3,1.2) * tile_size/2

# Character controler ###############################################
func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding() and steps < max_steps:
		make_animation(dir)
		steps += 1

func make_animation(dir):
	var tween = create_tween()
	tween.tween_property(self, "position",
	position + inputs[dir] *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false


func _process(delta):
	pass
