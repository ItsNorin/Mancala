# 
# PieceManager
#
# Used to create new pieces of random color and rotation
#

tool
extends Node2D

class_name PieceManager

# All possible colors of pieces
export(Array, Color) var pieceColors

# Creates a new randomly colored piece
# Must be freed manually!
func _getNewPiece(radius:float) -> Piece:
	var pV:PieceVisible = PieceVisible.new()
	pV.setPieceColor(pieceColors[randi() % pieceColors.size()])
	pV.rotate(rand_range(0, 2*PI))
	pV.setRadius(radius)
	add_child(pV)
	return Piece.new(pV)

func remove_all_children():
	for c in self.get_children():
		.remove_child(c)
		c.queue_free()
	pass

func getNewPieces(radius:float, count:int = 1):
	var pa = []
	pa.resize(count)
	for i in count:
		pa[i] = _getNewPiece(radius)
	return pa

func _ready():
	randomize()
	pass
