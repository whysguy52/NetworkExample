extends Spatial

var cameraNod
var pilot

var ShipOrientation
var CameraOrientation
var NodOrientation
var stepTowardsCamera

var isDoneRotating = true

# Called when the node enters the scene tree for the first time.
func _ready():
	cameraNod = get_parent().get_node("PilotControls/CameraNod")
	pilot = get_parent().get_node("PilotControls")

func turnShip(isUpdating):
	ShipOrientation = Quat(transform.basis)
	
	if isUpdating:
		CameraOrientation = Quat(cameraNod.global_transform.basis)
	
	stepTowardsCamera = ShipOrientation.slerp(CameraOrientation,0.01)
	
	transform.basis = Basis(stepTowardsCamera)
	
	var quatDiff = CameraOrientation.dot(ShipOrientation)
	if quatDiff > 0.9999:
		pilot.isDoneRotating = true
	rpc("RemoteTurnShip",transform)

remote func RemoteTurnShip(shipTransform):
	transform = shipTransform
	#this is a comment
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
