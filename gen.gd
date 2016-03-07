extends TileMap

var x = 0
var y = 0

var x_max = 256

var dir = 0

var dungeon_gen

var dungeons = 0
var dungeons_max = 8

var dun_array = []

func _ready():
	
	randomize()
	gen()

func gen():
	x = 0
	y = 0
	for dungeons in range(0,dungeons_max):
		dun_array.append(randi()%x_max)
		dungeon_gen = load("res://dungeongen.scn").instance()
		dungeon_gen.set_pos(map_to_world(Vector2(dun_array[dungeons],0)))
		add_child(dungeon_gen)
	print(dun_array)
	while x <= x_max:
		
		x+=1
		set_cell(x,y,1)
		
		dir = randi()%4
		if dir == 0:
			x+=1
		if dir == 1:
			x+=-1
		if dir == 2:
			y+=1
		if dir == 3:
			y+=-1
		set_cell(x,y,1)
	walls()

func walls():
	for x in range(-256,512):
		for y in range(-512,512):
			if get_cell(x,y) == 1:
				if get_cell(x+1,y) == -1:
					set_cell(x+1,y,0)
				if get_cell(x-1,y) == -1:
					set_cell(x-1,y,0)
				if get_cell(x,y+1) == -1:
					set_cell(x,y+1,0)
				if get_cell(x,y-1) == -1:
					set_cell(x,y-1,0)