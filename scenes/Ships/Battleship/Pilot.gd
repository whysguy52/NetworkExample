extends KinematicBody


var role
var cameraOrbit
var cameraNod
var MOUSE_SENSITIVITY = 0.05
var isTurning = false
var ShipRotation: Vector3


# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	if role != "pilot":
		return
	$CameraOrbit/CameraNod/PilotCam.make_current()
	cameraOrbit = $CameraOrbit
	cameraNod = $CameraOrbit/CameraNod
	
	#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _physics_process(delta):
	if role != "pilot":
		return
	process_input(delta)

func process_input(delta):
	if Input.is_action_pressed("LMB") or Input.is_action_pressed("RMB"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		if Input.is_action_pressed("RMB"):
			turnShip(delta, cameraOrbit, cameraNod)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	

func _input(event):
	if role != "pilot":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cameraOrbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		cameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		

func turnShip(delta, cameraH, cameraV):
	var t = 0
	t = t + delta * 1
	
	ShipRotation.y = cameraH.rotation_degrees.y
	ShipRotation.z = cameraV.rotation_degrees.z
	
	#self.rotation_degrees = self.rotation_degrees.linear_interpolate(ShipRotation, t)
	
	self.rotation_degrees += ShipRotation
	cameraOrbit.rotation_degrees.y = 0
	cameraNod.rotation_degrees.z = 0
#	print(delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
