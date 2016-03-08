extends Node2D

var count = 0
var count_max = 128

var dir = 0

var x = 0
var y = 0

func _ready():
	randomize()
	x = get_node("../").world_to_map(get_pos()).x
	y = get_node("../").world_to_map(get_pos()).y
	while count != count_max:
		
		dir = randi()%4
		
		if dir == 0:
			x+=1
		if dir == 1:
			x+=-1
		if dir == 2:
			y+=1
		if dir == 3:
			y+=-1
		
		get_node("../").set_cell(x,y,3)
		get_node("../../gui/map").set_cell(x,y,3)
		get_node("../../upps").set_cell(x,y,-1)
		
		count+=1