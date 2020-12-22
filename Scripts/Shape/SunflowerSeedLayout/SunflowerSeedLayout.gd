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

export (float, 0, 4) var alpha = 2 setget setAlpha

func setAlpha(a:float):
	alpha = a;
	updateChildPositions()
	pass

func updateChildPositions():
	# gathers all Node2D children for arranging
	var children = getAllArrangableChildren()
	
	var cc:int = children.size()
	
	if cc > 1:
		var bp:int = round(alpha * sqrt(cc))
		for i in range(0,cc):
			
			var r:float = radius
			if i < cc - bp:
				r = radius * sqrt(i + 0.5) / sqrt(cc - (bp + 1) * 0.5)
			
			var theta:float = 2*PI*i / pow(PHI,2)
			
			var cP:Vector2 = r * Vector2(cos(theta), sin(theta))
			(children[i]  as Node2D).position = cP
			
	# if only one child, puts child at 0,0 offset
	elif cc == 1:
		(children.front() as Node2D).position = Vector2(0,0)
	
	pass
