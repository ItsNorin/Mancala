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

var pieceVisible:PieceVisible
var tween:Tween

func _init(pv:PieceVisible):
	pieceVisible = pv
	tween = Tween.new()
	add_child(tween)
	pass

func animateMovement(speed:float = 1.0):
	if pieceVisible != null:
# warning-ignore:return_value_discarded
		tween.interpolate_property(
			pieceVisible,"position",
			pieceVisible.position, self.position, speed,
			Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
# warning-ignore:return_value_discarded
		tween.start()
	pass
	

func _exit_tree():
	pieceVisible.queue_free()
	tween.queue_free()