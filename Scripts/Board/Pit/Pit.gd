#
# Pit
#
# Stores and arranges pieces
# 

tool
extends Node2D

class_name Pit

export (float, 16, 256) var radius = 64
export (float, 16, 256) var pileRadius = 56
var layout:SunflowerSeedLayout

func addPiece(p:Piece):
	layout.add_child(p)
	pass

func addPieces(pa:Array):
	layout.add_child_many(pa)
	pass
	
func withdrawAllPieces() -> Array:
	var pieces = layout.get_children()
	return pieces

func pieceCount() -> int:
	return layout.get_child_count()

func _init():
	layout = SunflowerSeedLayout.new()
	layout.setRadius(pileRadius)
	add_child(layout)
	pass
	
func _exit_tree():
	layout.queue_free()
	pass
