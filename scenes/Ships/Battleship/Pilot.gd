extends KinematicBody


var role

var cameraOrbit
var cameraNod
var cameraTilt

var MOUSE_SENSITIVITY = 0.05

var ShipOrientation
var CameraOrientation
var NodOrientation
var stepTowardsCamera
var stepTowardsShip

var isDoneRotating = true

export var rotationRate = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	if role != "pilot":
		return
	$CameraOrbit/CameraNod/PilotCam.make_current()
	cameraOrbit = $CameraOrbit
	cameraNod = $CameraOrbit/CameraNod
	cameraTilt = $CameraOrbit/CameraNod/PilotCam
	
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
			turnShip(true)
			isDoneRotating = false
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if !isDoneRotating:
			turnShip(false)
	

func _input(event):
	if role != "pilot":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cameraOrbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		cameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	

func turnShip(isUpdating):
	
	#Use cameraNod instead of PilotCam because it's initial rotation is 0.
	
	ShipOrientation = Quat(transform.basis)
	
	if isUpdating:
		CameraOrientation = Quat(cameraNod.global_transform.basis)
		NodOrientation = Quat(cameraNod.global_transform.basis)
	
	stepTowardsCamera = ShipOrientation.slerp(CameraOrientation,0.01)
	stepTowardsShip = NodOrientation.slerp(CameraOrientation,0.01)
	
	transform.basis = Basis(stepTowardsCamera)
	cameraNod.global_transform.basis = Basis(stepTowardsShip)
	
	var quatDiff = CameraOrientation.dot(ShipOrientation)
	if quatDiff > 0.9999:
		isDoneRotating = true
	
	#print(ShipOrientation)
	print(quatDiff)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
