extends Node

const PORT = 31400

var playerList : Dictionary = {}
var myPlayerData = {"userName": "", "role": ""}

signal server_initiated
signal new_client_connected
signal player_connected
signal player_disconnected

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().connect("connected_to_server", self, "_on_client_connected")
	get_tree().connect("network_peer_disconnected", self, "_on_network_peer_disconnected")


func initiate_server(userName : String):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_server(PORT)
	get_tree().set_network_peer(peer)
	myPlayerData = {"userName": userName, "role": ""}
	emit_signal("server_initiated", myPlayerData)
	
	
	
remote func player_connected(id, playerData):
	playerList[id] = playerData
	emit_signal("player_connected")
	
	

func join_server(ipAddress, userName):
	var peer = NetworkedMultiplayerENet.new()
	peer.create_client(ipAddress, PORT)
	get_tree().set_network_peer(peer)
	myPlayerData["userName"] = userName
	

func _on_client_connected():
	var id = get_tree().get_network_unique_id()
	rpc_id(1, "new_client_connected",id, myPlayerData)
	emit_signal("new_client_connected")
	

remote func new_client_connected(id, playerData):
	if get_tree().is_network_server():
		for playerId in playerList:
			var peerData = playerList[playerId]
			rpc_id(id, "player_connected", playerId, peerData)
		player_connected(id, playerData)
		rpc("player_connected",id, playerData)
		print(playerData)
		

func disconnect_player():
	var id = get_tree().get_network_unique_id()
	get_tree().network_peer = null
	playerList.clear()

func _on_network_peer_disconnected(id):
	print("about to disconnect the player")
	playerList.erase(id)
	emit_signal("player_disconnected")
	

remotesync func _load_game():
	var nextScene = preload("res://scenes/Levels/TestLevel.tscn").instance()
	Global.go_to_scene(nextScene)

func load_game():
	rpc("_load_game")


