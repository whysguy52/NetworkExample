extends Spatial

#Camera parts
var cameraOrbit
var cameraNod

var role

var MOUSE_SENSITIVITY = 0.05

# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	
	if role != "gunner":
		return
	
	$CameraOrbit/CameraNod/Camera.make_current()
	cameraOrbit = $CameraOrbit
	cameraNod = $CameraOrbit/CameraNod
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	if role != "gunner":
		return
	process_input(delta)

func process_input(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	

# Handles the "event" which is just the mouse motion
func _input(event):
	if role != "gunner":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_cam(event)
	

#Need to figur out how to keep guns pointed at same thing camera is pointed at.
func rotate_cam(event):
	cameraOrbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
	cameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	
