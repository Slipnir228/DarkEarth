extends CanvasLayer

var inv_open = false

var onfocusItem = false
var dragItem = false
var current_item_block = null

var inv_pressed = false 

var normalTex = preload("res://Assets/ART/UI/Tex/placeholder1.tex")
var focusTex = preload("res://Assets/ART/UI/Tex/placeholder2.tex")

func _ready():
	var arm = get_node("bg/Armor").get_children()
	for child in arm:
		child.connect("mouse_enter",self,"_focus_to_armor", [child.get_name()])
		child.connect("mouse_exit",self,"_unfocus_to_armor", [child.get_name()])
	var items = get_node("bg/Items").get_children()
	for child in items:
		child.connect("mouse_enter",self,"_focus_to_item", [child.get_name()])
		child.connect("mouse_exit",self,"_unfocus_to_item", [child.get_name()])
	
	set_process(true)

func _process(delta):
	if (Input.is_action_pressed("inv") and not inv_pressed):
		if inv_open == true:
			inv_open = false
			get_node("bg").hide()
		elif inv_open == false:
			inv_open = true
			get_node("bg").show()
	inv_pressed = Input.is_action_pressed("inv")
	
	
	if onfocusItem:
		if (has_node("bg/Items/"+current_item_block+"Item") and not dragItem and Input.is_action_pressed("ui_select")):

				dragItem = true
				print (dragItem)
				get_node("bg/Items").add_child(get_node("bg/Items/"+current_item_block+"Item"))
				remove_child(get_node("bg/Items/"+current_item_block+"Item"))
		if dragItem:
			if has_node("bg/Items/Item"):
				get_node("bg/Items/Item").set_pos(get_viewport().get_mouse_pos()+get_camera_screen_center()-Vector2(get_viewport_rect().size.x,get_viewport_rect().size.y)/2)
			if not Input.is_action_pressed("mouse_click") and current_item_block:
				get_node("bg/Items/"+current_item_block).add_child(get_node("bg/Items/Item"))
				remove_child(get_node("bg/Items/Item"))






func _unfocus_to_armor (name):
	get_node("bg/Armor/"+name).set_texture(normalTex)

func _focus_to_armor (name):
	get_node("bg/Armor/"+name).set_texture(focusTex)

func _unfocus_to_item (name):
	current_item_block = null
	onfocusItem = false
	get_node("bg/Items/"+name).set_texture(normalTex)

func _focus_to_item (name):
	current_item_block = name
	onfocusItem = true
	get_node("bg/Items/"+name).set_texture(focusTex)
	