extends "res://scripts/label_hover.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_gui_input(event):
	if event.is_pressed():
		NetworkManager.myPlayerData["role"] = "pilot"
		NetworkManager.playerList[get_tree().get_network_unique_id()] = NetworkManager.myPlayerData
		print(NetworkManager.playerList)
	

#remote func hide_label():
#	visible = false
