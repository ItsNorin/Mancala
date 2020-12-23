#
# Piece
#
# Moved instantly by board
# Use animateMovement to update visible piece's position
# 
# Created only by giving a valid new instance of pieceVisible
# Will free given pieceVisible when freed
tool
extends Node2D

class_name Piece

var pieceVisible:PieceVisible = null

onready var tween = $Tween

func _init(pv:PieceVisible):
	pieceVisible = pv
	pass

func animateMovement(speed:float = 1.0):
	if pieceVisible != null:
		tween.interpolate_property(
			pieceVisible,"position",
			pieceVisible.position, self.position, speed,
			Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
		tween.start()
	pass

func _exit_tree():
	pieceVisible.free()
