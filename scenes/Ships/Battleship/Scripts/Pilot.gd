extends Spatial


var role

var CameraNod
var ShipBody
var HUD
var orientationLocked = false

var MOUSE_SENSITIVITY = 0.05

var isDoneRotating = true
var isUpdating = false

# Called when the node enters the scene tree for the first time.
func _ready():
	role = NetworkManager.myPlayerData["role"]
	if role != "pilot":
		return
	ShipBody = get_parent().get_node("ShipBody")
	CameraNod = $CameraNod
	$CameraNod/PilotCam.make_current()
	HUD = get_parent().get_node("PilotHud")
	HUD.visible = true

func _physics_process(delta):
	if role != "pilot":
		return
	process_input()

func process_input():
	
	#Check if it's a mouse button
	if Input.is_action_pressed("LMB") or Input.is_action_pressed("RMB"):
		
		#Lock the mouse
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		#if it's RMB, tell ship to update cam direction
		if Input.is_action_pressed("RMB"):
			isUpdating = true
			ShipBody.turn_ship(isUpdating,orientationLocked)
			isDoneRotating = false
		
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	if !isDoneRotating and !Input.is_action_pressed("RMB"):
			isUpdating = false
			ShipBody.turn_ship(false,orientationLocked)
	
	if Input.is_action_pressed("ui_roll_left") or Input.is_action_pressed("ui_roll_right"):
		ShipBody.roll_ship()
	
	#this may be overly redundant
	ShipBody.transform.orthonormalized()

func _input(event):
	if role != "pilot":
		return
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(deg2rad(event.relative.x * MOUSE_SENSITIVITY * -1))
		CameraNod.rotate_z(deg2rad(event.relative.y * MOUSE_SENSITIVITY * -1))
	

func _on_CheckButton_toggled(button_pressed):
	if orientationLocked == false:
		orientationLocked = true
	else:
		orientationLocked = false
	isUpdating = true
