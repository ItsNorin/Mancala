tool
extends Node2D

class_name PieceVisible

export (Color) var pieceColor setget setPieceColor
export (float, 1, 128) var radius setget setRadius

var sprite:Sprite

var MARBLE_TEXTURE_1 = preload("res://Res/Img/marbleBase1.svg")
var MARBLE_MATERIAL = preload("res://Res/Material/PieceShader.tres") 

func setRadius(r:float):
	radius = r
	if sprite != null:
		var s:Vector2 = sprite.texture.get_size()
		sprite.scale = 2 * Vector2(r / s.x, r / s.y)
	pass

func setPieceColor(color:Color):
	pieceColor = color
	setShaderParam("color", pieceColor)
	pass
	
func setShaderParam(param:String, value):
	if sprite != null:
		sprite.material.set_shader_param(param, value)
	pass

func _init():
	sprite = Sprite.new()
	sprite.texture = MARBLE_TEXTURE_1
	sprite.material = MARBLE_MATERIAL
	add_child(sprite)
	pass

func _ready():
	setPieceColor(pieceColor)
	pass 
	
func _exit_tree():
	sprite.queue_free()
