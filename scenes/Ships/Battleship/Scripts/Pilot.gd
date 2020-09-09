extends Spatial


var role

var cameraOrbit
var cameraNod
var ShipBody

var MOUSE_SENSITIVITY = 0.05

var isDoneRotating = true

# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	if role != "pilot":
		return
	ShipBody = get_parent().get_node("ShipBody")
	cameraNod = $CameraNod
	$CameraNod/PilotCam.make_current()
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta):
	if role != "pilot":
		return
	process_input()

func process_input():
	if Input.is_action_pressed("LMB") or Input.is_action_pressed("RMB"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if Input.is_action_pressed("RMB"):
			ShipBody.turnShip(true)
			isDoneRotating = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if !isDoneRotating:
			ShipBody.turnShip(false)
	

func _input(event):
	if role != "pilot":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		cameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
