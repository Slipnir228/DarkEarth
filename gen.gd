extends TileMap

var x = 0
var y = 0

var x_max = 256

var dir = 0

var dungeon_gen

var dungeons = 0
var dungeons_max = 8

var dun_array = []

var id_side = 4
var id_pass = 3
var id_border_up = 1
var id_border_down = 2
		
#x1=-128
#x2=384
#y1=-256
#y2=256

onready var upps = get_node("../upps")
onready var down = get_node("../down")
onready var map = get_node("../gui/map")
onready var gg = get_node("../gg")

var map_show = false
var key_pressed_m = false

func _process(delta):
	if map_show == false:
		map.hide()
	else:
		map.show()
	
	if Input.is_action_pressed("map_toggle") and map_show == false and key_pressed_m == false:
		map_show = true
		key_pressed_m = true
	if Input.is_action_pressed("map_toggle") and map_show == true and key_pressed_m == false:
		map_show = false
		key_pressed_m = true
	if not Input.is_action_pressed("map_toggle"):
		key_pressed_m = false
	
	map.set_pos(-gg.get_pos()*0.1+Vector2(128,72))
	
	
func _ready():
	set_process(true)
	randomize()
	gen()

func fill():
	for x in range(-128,384):
		for y in range(-256,256):
			upps.set_cell(x,y,0)
			
			

func gen():
	fill()
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
		set_cell(x,y,id_pass)
		map.set_cell(x,y,id_pass)
		upps.set_cell(x,y,-1)
		
		dir = randi()%4
		if dir == 0:
			x+=1
		if dir == 1:
			x+=-1
		if dir == 2:
			y+=1
		if dir == 3:
			y+=-1
		set_cell(x,y,id_pass)
		map.set_cell(x,y,id_pass)
		upps.set_cell(x,y,-1)
	walls(-128, 384, -256, 256)



func walls(x1,x2,y1,y2):
	for x in range(x1,x2):
		for y in range(y1,y2):
			
			
			if upps.get_cell(x,y) == 0 or upps.get_cell(x,y) == id_side: 
				if upps.get_cell(x,y-1) == -1:
					upps.set_cell(x,y-1, id_border_up)
				
					
			if upps.get_cell(x,y) == 0 or upps.get_cell(x,y) == id_side: 
				if upps.get_cell(x,y+1) == -1: 
					down.set_cell(x,y,id_border_down)
					upps.set_cell(x,y,-2)
					
			
			if upps.get_cell(x,y) == id_border_up:
				if upps.get_cell(x,y+1) == -1:
					destroy(x,y)
			
			if down.get_cell(x,y) == id_border_down:
				if upps.get_cell(x,y-1) == -1:
					upps.set_cell(x,y-1,id_border_up)
			
			if upps.get_cell(x,y) == 0:
				if (upps.get_cell(x+1,y) == -1 or upps.get_cell(x-1,y) == -1):
					if (upps.get_cell(x,y+1) != -1 and upps.get_cell(x,y-1) != -1):
						upps.set_cell(x,y, id_side)


func destroy(x,y):
	set_cell(x,y,3)
	upps.set_cell(x,y,-1)
	down.set_cell(x,y,-1)
	walls(x-10,x+10,y-10,y+10)
