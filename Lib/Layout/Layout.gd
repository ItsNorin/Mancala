
tool
extends Node2D
class_name Layout

export (bool) var update = false setget setUpdate

func updateChildPositions():
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

# Moves child node to new position amongst children then updates all child positions
func move_child(node:Node, to_position:int):
	.move_child(node, to_position)
	updateChildPositions()
	pass

# Removes child then updates all child positions
func remove_child(node:Node):
	.remove_child(node)
	updateChildPositions()
	pass
	
func remove_all_children():
	for c in self.get_children():
		.remove_child(c)
		c.queue_free()
	pass

func getAllArrangableChildren() -> Array:
	var children = []
	for c in self.get_children():
		if c is Node2D:
			children.push_back(c)
	return children

func _ready():
	updateChildPositions()
	pass
