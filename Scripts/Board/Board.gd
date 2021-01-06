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

export (int, 2, 8) var sideCount = 5 setget setSides
export (int, 1, 16) var pitCount = 7 setget setPitCount
export (int, 0, 24) var startingPieces = 4 setget setStartingPieces
export (float, 1, 128) var pitRadius = 32 setget setPitRadius
export (float, 0.1, 1) var pieceScale = 0.3 setget setPieceScale
export (float, 0.1, 1) var pitPileScalar = 0.4 setget setPitPileScalar

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

func setPitRadius(r:float):
	pitRadius = r
	setUpdate()
	pass
	
# warning-ignore:unused_argument
func setUpdate(b:bool = false):
	setSides(sideCount)
	pass

func setSides(s:int):
	sideCount = s
	
	if layout != null:
		# clear all pieces
		pieceManager.remove_all_children()
		
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
		
		
		var sideLength:float = (sides.front() as PlayerRow).length()
		sideLength += 2.0*(pitRadius/cos(theta/2.0) - pitRadius)
		var layoutRadius:float = sideLength / (2.0 * tan(PI / sideCount))
		
		# update layout
		layout.remove_all_children()
		layout.setRadius(layoutRadius)
		layout.add_child_many(sides)
		
		var pieceRadius = pitRadius * pieceScale
		
		# add pieces to sides
		for i in sideCount:
			for j in range(1, pitCount):
				var pcs = pieceManager.getNewPieces(pieceRadius, startingPieces)
				var p:Pit = (sides[i] as PlayerRow).getPit(j)
				p.addPieces(pcs)
	
	
	
	pass

func _ready():
	setSides(sideCount)
	pass
	
func _process(delta):
	if pieceManager != null:
		pieceManager.updatePiecePositions()
	pass
