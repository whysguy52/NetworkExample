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
	var playerList = get_node("MarginContainer/VBoxContainer/LobbySlots/PlayerListContainer")
	var playerRoles = get_node("MarginContainer/VBoxContainer/LobbySlots/PlayerRoleList")
	Global.clear_children(playerList)
	Global.clear_children(playerRoles)
	for id in NetworkManager.playerList:
		# get player name and role from network manager
		var playerName = NetworkManager.playerList[id].get("userName")
		var playerRole = NetworkManager.playerList[id].get("role")
		#Create a new label for player and their role
		var newPlayer = Label.new()
		var newRole = Label.new()
		#enter the text in the new labels
		newPlayer.text = playerName
		newRole.text = playerRole
		#set that players id as the name of the node (name is the node name)
		newPlayer.set_name(str(id))
		
		playerList.add_child(newPlayer)
		playerRoles.add_child(newRole)
	print("player list updated")
