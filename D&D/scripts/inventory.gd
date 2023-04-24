extends Node

class_name Inventory

var character       : Character
var selected_weapon : Weapon
var bag             : Array[Item]
var max_bag_size    : int 


func _init(char : Character):
	self.character       = char
	self.selected_weapon = Weapon.new("Fist", 1, true)
	self.max_bag_size    = char.bag_size
	self.bag             = []

func change_selected_weapon(weapon : Weapon):
	selected_weapon = weapon

func add_bag_item(item : Item):
	if bag.size() < max_bag_size:
		bag.append(item)

func check_hit_range(char_attack : Character, char_defend : Character) -> bool:
	return selected_weapon.check_hit_range(char_attack, char_defend)
