extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	NetworkManager.connect("player_connected", self, "_on_player_connected")
	NetworkManager.connect("player_disconnected", self, "_on_player_disconnected")
	print("We are ready")


func initiate_server():
	print("hello lobby")

func _on_player_connected():
	print("Player Connected and stuff")
	render_player_list()
	

func _on_player_disconnected():
	render_player_list()

func render_player_list():
	var playerList = get_node("MarginContainer/VBoxContainer/PlayerListContainer")
	Global.clear_children(playerList)
	for id in NetworkManager.playerList:
		var playerName = NetworkManager.playerList[id].get("userName")
		var newPlayer = Label.new()
		newPlayer.text = playerName
		newPlayer.set_name(str(id))
		playerList.add_child(newPlayer)
	print("player list updated")
