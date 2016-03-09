extends Camera2D

var mousepos = Vector2()

func _ready():
	set_process(true)

func _process(delta):
	mousepos = get_viewport().get_mouse_pos()+get_camera_screen_center()-Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)/2
	
	if has_node("../gg"):
		set_pos(get_node("../gg").get_pos())
		set_follow_smoothing(5)
	else:
		set_pos(mousepos)
		set_follow_smoothing(1)
	
	if Input.is_action_pressed("mouse_click"):
		var x = mousepos.x
		var y = mousepos.y
		var g = get_node("../ground")
		x = g.world_to_map(Vector2(x, y)).x
		y = g.world_to_map(Vector2(x, y)).y
		g.destroy(x,y)
