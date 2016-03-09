extends Node2D

onready var popup = get_node("popups/popup")

func _ready():
	OS.set_window_maximized(true)

func popup(text, pos):
	popup.set_text(text)
	popup.set_pos(pos)
	popup.show()

func hide_popup():
	popup.hide()