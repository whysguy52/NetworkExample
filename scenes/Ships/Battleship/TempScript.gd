extends MeshInstance

var shipBody

# Called when the node enters the scene tree for the first time.
func _ready():
	shipBody = get_parent().get_node("ShipBody")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#transform.basis = shipBody.transform.basis
	transform.scaled(Vector3(20,1,1))
