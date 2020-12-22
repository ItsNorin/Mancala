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
extends Node2D

class_name CircleLayout

# number of points this shape has
export (float, 0, 2048) var radius = 1.0 setget setRadius
export (bool) var update = false setget setUpdate

func setRadius(r:float):
	radius = r
	updateChildPositions()
	pass
	
# warning-ignore:unused_argument
func setUpdate(u:bool):
	updateChildPositions()
	pass

# Addes node as child then updates all child positions
func add_child(node:Node, legible_unique_name:bool = false):
	.add_child(node, legible_unique_name)
	updateChildPositions()
	pass

# Adds multiple children from given array of nodes then updates all child positions
func add_child_many(nodes:Array, legible_unique_name:bool = false):
	for n in nodes:
		.add_child(n, legible_unique_name)
	updateChildPositions()
	pass
	
# Adds child below node then updates all child positions
func add_child_below_node(node:Node, child_node:Node, legible_unique_name:bool = false):
	.add_child_below_node(node, child_node, legible_unique_name)
	updateChildPositions()
	pass

# Removes child then updates all child positions
func remove_child(node:Node):
	.remove_child(node)
	updateChildPositions()
	pass

# Arranges all children that are Node2D's in a circle
# This is done automatically but can be done manually if needed
func updateChildPositions():
	# gathers all Node2D children for arranging
	var children = []
	for c in self.get_children():
		if c is Node2D:
			children.push_back(c)
	
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

func _ready():
	updateChildPositions()
	pass
