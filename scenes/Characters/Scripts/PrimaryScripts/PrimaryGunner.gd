extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var MOUSE_SENSITIVITY = 0.12
var role

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	role = NetworkManager.myPlayerData["role"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if role == "gunner":
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			rotate(deg2rad(event.relative.x * MOUSE_SENSITIVITY))
		var angle = rotation_degrees
		rpc("update_rotation", angle)

remote func update_rotation(angle):
	self.rotation_degrees = angle
