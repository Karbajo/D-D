extends Node

enum range {MELEE, DISTANCE}

class weapon:
	var weapon_name : String
	var damage      : int
	var range_type  : range
	
	func _init(w_name, dmg, rg):
		weapon_name = w_name
		damage = dmg
		range_type = rg

var w1 = weapon.new("weapon1", 1, range.MELEE)

var weapons = [w1]


