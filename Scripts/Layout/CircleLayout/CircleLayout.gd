#
# Circle Layout 2D
# 
# Node2D that will lay out its children evenly along a circle of a given radius
# Will only lay out children that are or inherit from Node2D
#
# Will update position of all children possible every time new node is added
# If many children need to be added, use add_child_many method.
#
# 
# TODO
# Fix node's position not updating when reparented in editor after being moved manually
#

tool
extends Layout

class_name CircleLayout

# number of points this shape has
export (float, 0, 2048) var radius = 1.0 setget setRadius

func setRadius(r:float):
	radius = r
	updateChildPositions()
	pass

# Arranges all children that are Node2D's in a circle
# This is done automatically but can be done manually if needed
func updateChildPositions():
	# gathers all Node2D children for arranging
	var children = getAllArrangableChildren()
	
	var cc:int = children.size()
	
	# arranges in circle
	if cc > 1:
		var theta:float = 2.0 * PI / cc
		for i in cc:
			var tI:float = theta * i
			var cP:Vector2 = Vector2(cos(tI), sin(tI)) * radius
			(children[i] as Node2D).position = cP
	# if only one child, puts child at 0,0 offset
	elif cc == 1:
		(children.front() as Node2D).position = Vector2(0,0)
	
	pass
