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

var ROW = preload("res://Scripts/Board/PlayerRow/PlayerRow.tscn")

export (int, 2, 12) var sideCount = 5 setget setSides
export (int, 1, 16) var pitCount = 7 setget setPitCount
export (int, 0, 24) var startingPieces = 4 setget setStartingPieces
export (float, 0.1, 1) var pieceScale = 0.3 setget setPieceScale
export (float, 0.1, 1) var pitPileScalar = 0.4 setget setPitPileScalar
export (float, 64, 1024) var desiredSize = 500 setget setDesiredSize

export (bool) var update = false setget setUpdate

func setPitPileScalar(s:float):
	pitPileScalar = s
	setUpdate()
	pass

func setPieceScale(s:float):
	pieceScale = s
	setUpdate()
	pass

func setPitCount(p:int):
	pitCount = p
	setUpdate()
	pass
	
func setStartingPieces(p:int):
	startingPieces = p
	setUpdate()
	pass

func setDesiredSize(s:float):
	desiredSize = s
	setUpdate()
	pass
	
# warning-ignore:unused_argument
func setUpdate(b:bool = false):
	setSides(sideCount)
	pass


func _createNewSides(pitRadius:float) -> Array:
	# create needed pits
	var theta:float = 2*PI/sideCount
	
	var sides = []
	sides.resize(sideCount)
	for i in sideCount:
		var r:PlayerRow = ROW.instance()
		r.setPitCount(pitCount)
		r.setPitRadius(pitRadius)
		r.setPileScalar(pitPileScalar)
		r.rotate(theta*i + PI/2)
		
		sides[i] = r
	
	return sides

func setSides(s:int):
	sideCount = s
	
	if layout != null:
		# clear all pieces
		pieceManager.remove_all_children()
		
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
		layout.remove_all_children()
		layout.setRadius(layoutRadius)
		layout.add_child_many(sidesArr)
		
		# add pieces to sides
		var pieceRadius = pitRadius * pieceScale
		
		for i in sideCount:
			for j in range(1, pitCount):
				var pcs = pieceManager.getNewPieces(pieceRadius, startingPieces)
				var p:Pit = (sidesArr[i] as PlayerRow).getPit(j)
				p.addPieces(pcs)
	
	pass

func _ready():
	setSides(sideCount)
	pass
	
func _process(delta):
	if pieceManager != null:
		pieceManager.updatePiecePositions()
	pass
