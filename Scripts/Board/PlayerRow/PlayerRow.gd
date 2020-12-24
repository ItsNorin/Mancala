tool
extends Node2D

class_name PlayerRow

export (int, 1, 12) var pitCount = 6 setget setPitCounts
export (float, 0, 256) var spacing = 128 setget setLayoutSpacing

var layout:LineLayoutCentered = null
var PIT = preload("res://Scripts/Board/Pit/Pit.tscn")

func length() -> float:
	return layout.length() + spacing

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

func _init():
	layout = LineLayoutCentered.new()
	add_child(layout)
	layout.setSpacing(spacing)
	setPitCounts(pitCount)

func _exit_tree():
	layout.remove_all_children()
	layout.free()
	pass
