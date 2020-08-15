extends Spatial

var cameraOrbit
var cameraNod

var gun1Orbit
var gun2Orbit
var gun1Nod
var gun2Nod
var role

var turrets = []

var MOUSE_SENSITIVITY = 0.05


# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	if role != "gunner":
		return
	$CameraOrbit/CameraNod/Camera.make_current()
	cameraOrbit = $CameraOrbit
	cameraNod = $CameraOrbit/CameraNod
	
	gun1Orbit = $Gun1/Base
	gun2Orbit = $Gun2/Base
	
	gun1Nod = $Gun1/Base/PivotPoint
	gun2Nod = $Gun2/Base/PivotPoint
	
	turrets.append($Gun1/Base/PivotPoint/LaserSpawn)
	turrets.append($Gun2/Base/PivotPoint/LaserSpawn)
	
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
	if Input.is_action_just_pressed("LMB"):
		for turret in turrets:
			turret.fire()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if role != "gunner":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		cameraOrbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		cameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		
		gun1Orbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		gun1Nod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
		
		gun2Orbit.rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		gun2Nod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))

#		var camera_rot = cameraNod.rotation_degrees
#		camera_rot.x = clamp(camera_rot.x, -70, 70)
#		cameraNod.rotation_degrees = camera_rot
