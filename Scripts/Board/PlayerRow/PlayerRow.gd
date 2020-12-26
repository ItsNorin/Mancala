tool
extends Node2D

class_name PlayerRow

export (int, 1, 12) var pitCount = 6 setget setPitCounts
export (float, 0, 256) var pitRadius = 64 setget setPitRadius

var layout:LineLayoutCentered = null
var PIT = preload("res://Scripts/Board/Pit/Pit.tscn")

func length() -> float:
	return layout.length() + 2*pitRadius

func setPitRadius(r:float):
	pitRadius = r
	regeneratePits(pitCount, pitRadius)
	pass
	
func setPitCounts(pc:int):
	pitCount = pc
	regeneratePits(pitCount, pitRadius)
	pass

func regeneratePits(pc:int, pr:float):
	if layout != null:
		# create needed pits
		var pits = []
		pits.resize(pc)
		for i in pc:
			var p:Pit = PIT.instance()
			p.setRadius(pr)
			pits[i] = p
		
		# update layout
		layout.remove_all_children()
		layout.setSpacing(2*pr)
		layout.add_child_many(pits)
	pass
	
func getPit(i:int) -> Pit:
	return layout.get_child(i) as Pit

func _init():
	layout = LineLayoutCentered.new()
	add_child(layout)
	layout.setSpacing(2*pitRadius)
	setPitCounts(pitCount)

func _exit_tree():
	layout.remove_all_children()
	layout.free()
	pass
