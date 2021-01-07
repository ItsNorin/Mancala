#
# Pit
#
# Stores and arranges pieces
# 

tool
extends Node2D

class_name Pit

export (float, 16, 256) var radius = 64 setget setRadius
export (float, 0.1, 1) var pileRadiusScalar = 0.5 setget setPileRadiusScalar

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

func _setTextureRadius(r:float):
	var tex:TextureRect = get_node_or_null("Texture")
	if tex != null:
		tex.set_size(Vector2(r, r) * 2)
		tex.set_position(-Vector2(r, r))
	pass

func setRadius(r:float):
	radius = r
	_setTextureRadius(r)
	setPileRadiusScalar(pileRadiusScalar)
	pass
	
func setPileRadiusScalar(s:float):
	pileRadiusScalar = s
	layout.setRadius(radius * s)
	pass
	
func _init():
	layout = SunflowerSeedLayout.new()
	add_child(layout)
	pass
	
func _ready():
	_setTextureRadius(radius)
	pass

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			if event.global_position.distance_to(self.global_position) <= radius:
				print("Mouse Click at: ", self.global_position)
				get_tree().set_input_as_handled()
	pass
	
func _exit_tree():
	layout.queue_free()
	pass
