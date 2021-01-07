#
# Sunflower Seed Layout 2D
# 
# Node2D that will lay out its children evenly inside of a circle of a given radius
# Will only lay out children that are or inherit from Node2D
#
# Will update position of all children possible every time new node is added
# If many children need to be added, use add_child_many method.
#
tool
extends CircleLayout

class_name SunflowerSeedLayout

const PHI = (sqrt(5) + 1) / 2

# Order in which pieces are added to the arrangement
# If true, nodes closer to center render on top of those on edges
export (bool) var flipOrder = true setget setFlipOrder

# "Spread" of distribution, higher alpha value results in more nodes on the border
export (float, 0, 4) var alpha = 2 setget setAlpha



func setFlipOrder(f:bool):
	flipOrder = f
	updateChildPositions()
	pass

func setAlpha(a:float):
	alpha = a;
	updateChildPositions()
	pass
	
	
	
func updateChildPositions():
	# gathers all Node2D children for arranging
	var children = getAllArrangableChildren()
	
	var cc:int = children.size()
	
	if cc > 1:
# warning-ignore:narrowing_conversion
		var bp:int = round(alpha * sqrt(cc))
		for i in range(0,cc):
			
			var r:float = radius
			if i <= cc - bp:
				r = radius * sqrt(i + 0.5) / sqrt(cc - (bp + 1) * 0.5)
			
			var theta:float = 2*PI*i / pow(PHI,2)
			
			var cP:Vector2 = r * Vector2(cos(theta), sin(theta))
			
			var nodeIndex:int = (cc - i - 1) if flipOrder else (i)
			(children[nodeIndex]  as Node2D).position = cP
			
	# if only one child, puts child at 0,0 offset
	elif cc == 1:
		(children.front() as Node2D).position = Vector2(0,0)
	
	pass
