extends Node

class_name Inventory

var selected_weapon : Weapon
var bag             : Array[Item]
var max_bag_size    : int 


func _init(max_size : int):
	self.selected_weapon = Weapon.new("Fist", 1, false)
	self.max_bag_size    = max_size
	self.bag             = []

func change_selected_weapon(weapon : Weapon):
	selected_weapon = weapon

func add_bag_item(item : Item):
	if bag.size() < max_bag_size:
		bag.append(item)
