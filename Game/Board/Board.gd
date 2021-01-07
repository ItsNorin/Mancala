#
# Board
#
# Main game board that handles:
#  - Board layout and setup
#  - Piece positions and movement animations
#
# TODO: 
# Piece controller as child

tool
extends Node2D

onready var layout = $CircleLayout
onready var pieceManager = $PieceManager

var ROW = preload("PlayerRow/PlayerRow.tscn")

export (int, 2, 12) var sideCount = 5 setget setSides
export (int, 1, 16) var pitCount = 7 setget setPitCount
export (int, 0, 24) var startingPieces = 4 setget setStartingPieces
export (float, 0.1, 1) var pieceScale = 0.3 setget setPieceScale
export (float, 0.1, 1) var pitPileScalar = 0.4 setget setPitPileScalar
export (float, 64, 1024) var desiredSize = 500 setget setDesiredSize

export (bool) var update = false setget setUpdate

func setPitPileScalar(s:float):
	pitPileScalar = s
	_rebuildBoard()
	pass

func setPieceScale(s:float):
	pieceScale = s
	_rebuildBoard()
	pass

func setPitCount(p:int):
	pitCount = p
	_rebuildBoard()
	pass
	
func setStartingPieces(p:int):
	startingPieces = p
	_rebuildBoard()
	pass

func setDesiredSize(s:float):
	desiredSize = s
	_rebuildBoard()
	pass
	
func setSides(s:int):
	sideCount = s
	_rebuildBoard()
	pass
	
	
# warning-ignore:unused_argument
func setUpdate(b:bool = false):
	_rebuildBoard()
	pass



func _createNewSides(pitRadius:float) -> Array:
	# create needed pits
	var theta:float = 2*PI/sideCount
	
	var prevRow:PlayerRow = null
	
	var sides = []
	sides.resize(sideCount)
	for i in sideCount:
		var r:PlayerRow = ROW.instance()
		r.setPitCount(pitCount)
		r.setPitRadius(pitRadius)
		r.setPileScalar(pitPileScalar)
		r.rotate(theta*i + PI/2)
		
		# link pits between first row and last row
		if prevRow != null:
			var np:Pit = r.pits.front()
			(prevRow.pits.back() as Pit).linkNext(np)
		prevRow = r
		
		sides[i] = r
	
	# link last row to first row
	var np:Pit = (sides.front() as PlayerRow).pits.front()
	var pp:Pit = (sides.back() as PlayerRow).pits.back()
	pp.linkNext(np)
	
	return sides


func _rebuildBoard():
	if layout != null:
		# clear all pieces
		pieceManager.free_all_children()
		
		# calulate pit radius to scale board to given size
		var pitRadius:float = desiredSize / pitCount / 2
		var vOffset:float = 0
		
		if sideCount > 2:
			var the = PI/sideCount
			var alp = PI * (sideCount-2) / (2*sideCount)
			var r:float = desiredSize * sin(the)
			r /= (2*pitCount)  +  2*(1 - sin(the)*cos(alp)) * (1 - cos(the)) / cos(the)
			pitRadius = r
			# calculate vertical offset for odd numbers of rows
			if sideCount % 2 == 1:
				vOffset = ((r/cos(the) - r) * cos(alp) + r) / 2 
			
		var sidesArr = _createNewSides(pitRadius)
		
		# find layout radius
		var sideLength:float = 2*pitRadius*pitCount
		sideLength += 2.0*(pitRadius/cos(PI/sideCount) - pitRadius)
		var layoutRadius:float = sideLength / (2.0 * tan(PI / sideCount))
		
		layout.position = Vector2(0, vOffset)
		# update layout
		layout.free_all_children()
		layout.setRadius(layoutRadius)
		layout.add_child_many(sidesArr)
		
		# add pieces to sides
		var pieceRadius = pitRadius * pieceScale
		
		for i in sideCount:
			for j in range(1, pitCount):
				var pcs = pieceManager.getNewPieces(pieceRadius, startingPieces)
				var p:Pit = (sidesArr[i] as PlayerRow).pits[j]
				p.addPieces(pcs)
	pass


func connectPitClickSignals():
	if !Engine.is_editor_hint():
		var rows = layout.get_children()
		for r in rows:
			if r is PlayerRow:
				for p in (r as PlayerRow).pits:
					p.connect("pit_clicked", self, "_on_pit_click")
	pass

func _on_pit_click(pit):
	if pit is Pit:
		pieceManager.movePieces(pit)
	pass

func _ready():
	_rebuildBoard()
	connectPitClickSignals()
	pass
	
func _process(delta):
	if pieceManager != null:
		pieceManager.updatePiecePositions()
	pass
