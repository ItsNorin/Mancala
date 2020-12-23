#
# Pit
#
# Stores and arranges pieces
# 

tool
extends Node2D

class_name Pit

onready var layout:SunflowerSeedLayout = $SunflowerSeedLayout

func addPiece(p:Piece):
	layout.add_child(p)
	pass
	
	
func withdrawAllPieces() -> Array:
	var pieces = layout.get_children()
	return pieces

func pieceCount() -> int:
	return layout.get_child_count()

func _ready():
	pass
