tool
extends Node2D

export (int, 1, 12) var pitCount = 6 setget setPitCounts
export (float, 0, 256) var spacing = 128 setget setLayoutSpacing

var layout:LineLayout = null
var PIT = preload("res://Scripts/Board/Pit/Pit.tscn")

func setLayoutSpacing(s:float):
	spacing = s
	if layout != null:
		layout.setSpacing(s)
	pass

func setPitCounts(pc:int):
	pitCount = pc
	
	if layout != null:
		# create needed pits
		var pits = []
		pits.resize(pitCount)
		for i in pitCount:
			pits[i] = PIT.instance()
		
		# update layout
		layout.remove_all_children()
		layout.add_child_many(pits)
	pass
	
func getPit(i:int) -> Pit:
	return layout.get_child(i) as Pit

func _ready():
	layout = get_node("LineLayout")
	layout.setSpacing(spacing)
	setPitCounts(pitCount)
	
	pass

func _exit_tree():
	layout.remove_all_children()
	pass
