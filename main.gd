extends Node2D

onready var popup = get_node("popups/popup")

func popup(text, pos):
	popup.set_text(text)
	popup.set_pos(pos)
	popup.show()

func hide_popup():
	popup.hide()