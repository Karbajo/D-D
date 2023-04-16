extends Node

var party_members = {}
var turn = 0

func get_players_size():
	return party_members.size()

func get_actual_player():
	return party_members[turn]
