extends Item

class_name Weapon
enum range {MELEE, DISTANCE}
const tile_size = 1

var damage      : int
var range_type  : range

func _init(iname : String, dmg : int, is_ranged : bool):
	item_name = iname
	damage = dmg
	if is_ranged:
		range_type = range.DISTANCE
	else:
		range_type = range.MELEE

# Comprueba si el personaje atacante tiene a rango al personaje defensor
func check_hit_range(char_attack : Character, char_defend : Character) -> bool:
	var distance = char_defend.position.distance_to(char_attack.position)
	if range_type == range.MELEE:
		if distance <= tile_size:
			return true
	elif range_type == range.DISTANCE and distance > tile_size:
		var angle = Vector3(1,0,0).angle_to(char_defend.position - char_attack.position)
		if check_angle(angle):
			return true
	return false 

func check_angle(angle) -> bool:
	for i in range(8):
		if abs(angle - i*PI/4) < Controller.eps:
			return true
	return false

