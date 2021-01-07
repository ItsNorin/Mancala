# 
# Player
# 
# Used to interact with board
#
# Todo:
# 
# Saving of players to disk
# Keep all time scores
# AiPlayer

extends Node

class_name Player

var _playerID:int

func _init(playerID:int):
	_playerID = playerID
	pass

func _ready():
	pass
