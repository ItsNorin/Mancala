tool
extends Node2D

class_name PieceVisible

export (Color) var pieceColor setget setPieceColor

onready var textureMat:Material = $Tex.material
	
func setPieceColor(color:Color):
	pieceColor = color
	setShaderParam("color", pieceColor)
	pass
	
func setShaderParam(param:String, value):
	if textureMat != null:
		textureMat.set_shader_param(param, value)
	pass

func _ready():
	setShaderParam("color", pieceColor)
	pass 
