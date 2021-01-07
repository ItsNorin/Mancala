tool
extends LineLayout
class_name LineLayoutCentered

func updateChildPositions():
	var children = getAllArrangableChildren()
	
	var cc:int = children.size()
	
	for i in cc:
		(children[i] as Node2D).position = Vector2((i + 0.5 - cc*0.5)*spacing, 0)
	
	_length = (cc-1)*spacing
	pass
