tool
extends Node2D

class_name PlayerRow

export (int, 1, 12) var pitCount = 6 setget setPitCounts
export (float, 0, 256) var pitRadius = 64 setget setPitRadius

var layout:LineLayoutCentered = null
var PIT = preload("res://Scripts/Board/Pit/Pit.tscn")

var pits = []

func length() -> float:
	return layout.length() + 2*pitRadius

func setPitRadius(r:float):
	pitRadius = r
	_regeneratePits()
	pass
	
func setPitCounts(pc:int):
	pitCount = pc
	_regeneratePits()
	pass

func _regeneratePits():
	if layout != null:
		layout.remove_all_children()
		layout.setSpacing(2*pitRadius)
		
		# create needed pits
		pits.resize(pitCount)
		for i in pitCount:
			var p:Pit = PIT.instance()
			p.setRadius(pitRadius)
			pits[i] = p
		
		# update layout
		layout.add_child_many(pits)
	pass

func getPit(i:int) -> Pit:
	return pits[i]

func _init():
	layout = LineLayoutCentered.new()
	layout.setSpacing(2*pitRadius)
	setPitCounts(pitCount)
	add_child(layout)
	pass
