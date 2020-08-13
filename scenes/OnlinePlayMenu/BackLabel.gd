extends "res://scripts/label_hover.gd"

func _on_Label_gui_input(event):
	if event.is_pressed():
		get_tree().change_scene("res://scenes/MainMenu/MainMenu.tscn")

