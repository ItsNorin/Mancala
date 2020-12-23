# 
# PieceFactory
#
# Used to create new pieces of random color and rotation
#

tool
extends Node

# All possible colors of pieces
export(Array, Color) var pieceColors

# Creates a new randomly colored piece
# Must be freed manually!
func getNewPiece() -> Piece:
	var pV:PieceVisible = PieceVisible.new()
	pV.setPieceColor(pieceColors[randi() % pieceColors.size()])
	pV.rotate(rand_range(0, 2*PI))
	return Piece.new(pV)

func _ready():
	randomize()
	pass
