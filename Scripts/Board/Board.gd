#
# Board
#
# Main game board that handles:
#  - Board layout and setup
#  - Piece positions and movement animations
#

tool
extends Node2D

onready var layout = $CircleLayout
onready var pieceFactory = $PieceFactory

var ROW = preload("res://Scripts/Board/PlayerRow/PlayerRow.tscn")

export (int, 2, 8) var sideCount = 5 setget setSides
export (int, 1, 16) var pitCount = 7 setget setPitCount
export (int, 0, 24) var startingPieces = 4 setget setStartingPieces

export (bool) var update = false setget setUpdate

func setPitCount(p:int):
	pitCount = p
	setUpdate()
	pass
	
func setStartingPieces(p:int):
	startingPieces = p
	setUpdate()
	pass

# warning-ignore:unused_argument
func setUpdate(b:bool = false):
	setSides(sideCount)
	pass

func makeNewRow() -> PlayerRow:
	var r:PlayerRow = ROW.instance()
	r.setPitCounts(pitCount)
	for i in pitCount:
		var p:Pit = r.getPit(i)
		p.addPieces(pieceFactory.getNewPieces(startingPieces))
	return r

func setSides(s:int):
	sideCount = s
	
	if layout != null:
		# create needed pits
		var sides = []
		sides.resize(sideCount)
		for i in sideCount:
			var r:PlayerRow = makeNewRow()
			r.rotate(2*PI*i/sideCount + PI/2)
			sides[i] = r
		
		
		var sideLength:float = (sides.front() as PlayerRow).length()
		var layoutRadius:float = sideLength / (2 * tan(PI / sideCount))
		
		# update layout
		layout.remove_all_children()
		layout.setRadius(layoutRadius)
		layout.add_child_many(sides)
	pass

func _ready():
	setSides(sideCount)
	pass
