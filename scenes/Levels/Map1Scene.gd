extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var ship = preload("res://scenes/Characters/PlayerCharacter.tscn").instance()
	
	
	var pilotNode = ship.get_node("Pilot")
	var gunnerNode = ship.get_node("Gunner")
	
	for playerID in NetworkManager.playerList:
		var playerInfo = NetworkManager.playerList[playerID]
		print(playerInfo)
		if playerInfo["role"] == "pilot":
			pilotNode.set_network_master(playerID)
		elif playerInfo["role"] == "gunner":
			gunnerNode.set_network_master(playerID)
			
	add_child(ship)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
