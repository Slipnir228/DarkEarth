extends Area2D

var potions = ["Health potion","Mana potion"]

export var curPotion = 0

func _on_potions_body_enter( body ):
	if body.get_name() == "gg":
		if has_node("../gg"):
			get_node("../gg").on_item(potions[curPotion])

func _on_potions_body_exit( body ):
	if body.get_name() == "gg":
		if has_node("../gg"):
			get_node("../gg").left_item()
