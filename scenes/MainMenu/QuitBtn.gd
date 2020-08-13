extends "res://scripts/label_hover.gd"


func _on_QuitBtn_gui_input(event):
	if event.is_pressed():
		get_tree().quit()
