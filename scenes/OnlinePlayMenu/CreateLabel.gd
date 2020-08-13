extends "res://scripts/label_hover.gd"

onready var userNameInput = get_parent().get_node("GridContainer2/UserNameInput")

func _ready():
	NetworkManager.connect("server_initiated", self, "_on_server_initiated_confirm")

func _on_CreateBtn_gui_input(event):
	if event.is_pressed():
		NetworkManager.initiate_server(userNameInput.text)

func _on_server_initiated_confirm(data):
	var nextScene = preload("res://scenes/Lobby/Lobby.tscn").instance()
	Global.go_to_scene(nextScene)
	NetworkManager.player_connected(1, data)

