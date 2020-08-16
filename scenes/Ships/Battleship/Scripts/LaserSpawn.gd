extends Spatial

var laser = preload("res://scenes/Ships/Battleship/TurretParts/laser.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func fire():
	rpc("fire_total")

remotesync func fire_total():
	var clone = laser.instance()
	var scene_root = get_tree().root.get_children()[0]
	scene_root.add_child(clone)
	
	clone.global_transform = self.global_transform
	clone.scale = Vector3(1, 1, 1)
