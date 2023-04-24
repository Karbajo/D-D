extends Item

class_name Weapon
enum range {MELEE, DISTANCE}

var damage      : int
var range_type  : range

func _init(iname, dmg, is_ranged):
	item_name = iname
	damage = dmg
	if is_ranged:
		range_type = range.DISTANCE
	else:
		range_type = range.MELEE


