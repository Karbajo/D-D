extends Area3D

class_name Character

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

var order           = -1 #inicializacion de valor
var animation_speed = 4
var moving          = false
var is_his_turn     = false

# Stats ##############################################################
@export var character_name : String
@export var max_steps      : int
@export var max_actions    : int
@export var bag_size       : int
@export var max_health     : int
@export var max_mana       : int
@export var armor          : int

var inventory              : Inventory

var max_weapons     = 1
var weapons         = [] 
var selected_weapon = Weapon.new("weaponDistance", 1, true)

var health 
var mana 
var steps        = 0
var actions      = 1
var is_in_action = false


# Team ###############################################################
enum teams {allies, enemies}
@export var team : teams

@onready var outline = $Outline
var is_selected = false

var eps = 0.01   #Variable para restar enteros

######################################################################
# Code ###############################################################
######################################################################
func _ready():
	health  = max_health
	mana    = max_mana 
	
	position = position.snapped(Vector3(1,0.3,1) * tile_size)
	position += Vector3(1,0.3,1.2) * tile_size/2
	
	match team:
		teams.allies:
			add_to_group("allies")
		teams.enemies:
			add_to_group("enemies")

# Character controler ###############################################
func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	if order == Controller.turn:
		ray.target_position = inputs[dir] * tile_size
		ray.force_raycast_update()
		if check_ray_collision() and steps < max_steps:
			is_in_action = true
			make_animation(dir)
			steps += 1
		elif steps >= max_steps:
			check_actions()

func check_actions():
	if actions < max_actions:
		actions += 1
	else:
		get_parent_node_3d().change_turn()
		actions = 1
	steps = 0
	is_in_action = false

#Comprueba si es aliado o enemigo para poder atravesarlo o no
func check_ray_collision():
	var collider = ray.get_collider()
	if collider != null :
		if collider.has_method("get_team"):
			return collider.get_team() == team
		else:
			return false
	else: 
		return true 

func make_animation(dir):
	var tween = create_tween()
	tween.tween_property(self, "position",
	position + inputs[dir] *    tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false


func _process(delta):
	check_selected()

# attack ############################################################
func check_selected():
	if is_selected:
		if Input.is_action_just_pressed("interact"):
			check_hit()

func check_hit():
	var attack_character = Controller.get_actual_player()
	if !attack_character.is_in_action:
		if attack_character.team != team and check_hit_range(attack_character, attack_character.selected_weapon):
			health = health - attack_character.selected_weapon.damage
			attack_character.check_actions()
			print(health)

func check_hit_range(attack_character, weapon):
	var distance = position.distance_to(attack_character.position)
	if weapon.range_type == Weapon.range.MELEE:
		if distance <= tile_size:
			return true
	elif weapon.range_type == Weapon.range.DISTANCE and distance > tile_size:
		var angle = Vector3(1,0,0).angle_to(position - attack_character.position)
		print(angle)
		if check_angle(angle):
			return true
	return false 

func check_angle(angle):
	for i in range(8):
		if abs(angle - i*PI/4) < eps:
			return true
	return false
# signals ###########################################################
func _on_mouse_entered():
	outline.visible = true
	is_selected = true

func _on_mouse_exited():
	outline.visible = false
	is_selected = false

# getters & setters #################################################

func get_team():
	return team
