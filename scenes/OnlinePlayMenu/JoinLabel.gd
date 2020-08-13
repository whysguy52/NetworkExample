extends "res://scripts/label_hover.gd"

func _ready():
	NetworkManager.connect("new_client_connected", self, "_on_new_client_connected")

func _on_JoinBtn_gui_input(event):
	if event.is_pressed():
		var ipAddress = get_parent().get_node("ServerAddressInput").text
		var userName = get_node("/root/OnlinePlayerMenu/VBoxContainer/GridContainer2/UserNameInput").text
		NetworkManager.join_server(ipAddress, userName)

func _on_new_client_connected():
	var nextScene = preload("res://scenes/Lobby/Lobby.tscn").instance()
	Global.go_to_scene(nextScene)
