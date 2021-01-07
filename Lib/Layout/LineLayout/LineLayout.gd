tool
extends Layout
class_name LineLayout

export (float, 0, 1024) var spacing = 0 setget setSpacing
var _length:float = 0

func length() -> float:
	return _length

func setSpacing(s:float):
	spacing = s
	updateChildPositions()
	pass

func updateChildPositions():
	# gathers all Node2D children for arranging
	var children = getAllArrangableChildren()
	
	var cc:int = children.size()
	
	for i in cc:
		(children[i] as Node2D).position = Vector2(i*spacing, 0)
	_length = (cc-1)*spacing
	
	pass
