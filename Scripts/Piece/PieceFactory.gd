# 
# PieceFactory
#
# Used to create new pieces of random color and rotation
#

tool
extends Node

class_name PieceFactory

# All possible colors of pieces
export(Array, Color) var pieceColors

# Creates a new randomly colored piece
# Must be freed manually!
func _getNewPiece() -> Piece:
	var pV:PieceVisible = PieceVisible.new()
	pV.setPieceColor(pieceColors[randi() % pieceColors.size()])
	pV.rotate(rand_range(0, 2*PI))
	return Piece.new(pV)

func getNewPieces(count:int = 1):
	var pa = []
	pa.resize(count)
	for i in count:
		pa[i] = _getNewPiece()
	return pa

func _ready():
	randomize()
	pass
