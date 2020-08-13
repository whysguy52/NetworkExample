extends "res://scenes/Lobby/PlayerLabel.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlayerLabel_gui_input(event):
	if event.is_pressed():
		get_tree().change_scene("res://scenes/OnlinePlayMenu/OnlinePlayMenu.tscn")
