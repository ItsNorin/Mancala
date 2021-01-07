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
export (float, 0.1, 5) var pieceMoveSpeed = 1


var piecesToMove = []
var pieces = []


func movePieces(pit:Pit):
	var toMove:Array = pit.withdrawAllPieces()
	var pitPtr:Pit = pit.getNextPit()
	for p in toMove:
		if p is Piece:
			pitPtr.addPiece(p)
			for pToMv in pitPtr.getAllPieces():
				if pToMv is Piece:
					piecePositionChanged(pToMv)
			pitPtr = pitPtr.getNextPit()
			
	pass

func updatePiecePositions():
	for p in piecesToMove:
		if p is Piece:
			(p as Piece).animateMovement(-self.global_position, pieceMoveSpeed)
	piecesToMove.clear()
	pass

func piecePositionChanged(p:Piece):
	piecesToMove.append(p)
	pass

# Creates a new randomly colored piece
# Must be freed manually!
func _getNewPiece(radius:float) -> Piece:
	var pV:PieceVisible = PieceVisible.new()
	pV.setPieceColor(pieceColors[randi() % pieceColors.size()])
	pV.rotate(rand_range(0, 2*PI))
	pV.setRadius(radius)
	add_child(pV)
	var p = Piece.new(pV)
	pieces.append(p)
	piecePositionChanged(p)
	return p

func free_all_children():
	for c in self.get_children():
		.remove_child(c)
		c.queue_free()
	piecesToMove.clear()
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
