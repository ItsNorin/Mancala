tool
extends Node2D

class_name PlayerRow

export (int, 1, 12) var _pitCount = 6 setget setPitCount
export (float, 0, 256) var _pitRadius = 64 setget setPitRadius
export (float, 0.1, 1) var _pileScalar = 0.4 setget setPileScalar

var layout:LineLayoutCentered = null
var PIT = preload("Pit/Pit.tscn")

var pits = []

func length() -> float:
	return layout.length() + 2*_pitRadius

func setPileScalar(s:float):
	_pileScalar = s
	_regeneratePits()
	pass

func setPitRadius(r:float):
	_pitRadius = r
	_regeneratePits()
	pass
	
func setPitCount(pc:int):
	_pitCount = pc
	_regeneratePits()
	pass

func _regeneratePits():
	if layout != null:
		layout.remove_all_children()
		layout.setSpacing(2*_pitRadius)
		
		# create needed pits
		pits.resize(_pitCount)
		for i in _pitCount:
			var p:Pit = PIT.instance()
			p.rotate(rand_range(0, 2*PI))
			p.setRadius(_pitRadius)
			p.setPileRadiusScalar(_pileScalar)
			pits[i] = p
		
		# update layout
		layout.add_child_many(pits)
	pass

func getPit(i:int) -> Pit:
	return pits[i]

func _init():
	randomize()
	
	layout = LineLayoutCentered.new()
	layout.setSpacing(2*_pitRadius)
	add_child(layout)
	
	setPitCount(_pitCount)
	pass
