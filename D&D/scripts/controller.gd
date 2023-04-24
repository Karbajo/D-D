extends Node

var party_members = {}
var turn = 0

var eps = 0.01   #Variable para restar enteros

func get_players_size():
	return party_members.size()

func get_actual_player():
	return party_members[turn]

func initialize_character_inventory():
	for character in party_members.values():
		character.inventory = Inventory.new(character)


