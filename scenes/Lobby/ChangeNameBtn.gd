extends "res://scripts/label_hover.gd"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_gui_input(event):
	if event.is_pressed():
		var nameToBe = get_node("/root/LobbyMenu/NewName").text
		var myID = get_tree().get_network_unique_id()
		rpc("name_changed", myID, nameToBe)

remotesync func name_changed(id, nameToBe):
	NetworkManager.playerList[id] = {"userName": nameToBe}
	var Lobby = get_node("/root/LobbyMenu")
	Lobby.render_player_list()
