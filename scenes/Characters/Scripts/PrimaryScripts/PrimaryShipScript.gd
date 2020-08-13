extends Node2D

var speed = 400
var screenSize
var role

# Called when the node enters the scene tree for the first time.
func _ready():
	screenSize = get_viewport_rect().size
	role = NetworkManager.myPlayerData["role"]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process_input(delta)

func process_input(delta):
	if role == "pilot":
		var movement = Vector2()
		movement.x = -int(Input.is_action_pressed("ui_left")) + int(Input.is_action_pressed("ui_right"))
		movement.y = -int(Input.is_action_pressed("ui_up")) + int(Input.is_action_pressed("ui_down"))
		if movement == Vector2.ZERO:
			return
		movement = movement.normalized() * speed
		
		get_parent().position += movement * delta
		get_parent().position.x = clamp(get_parent().position.x, 0, screenSize.x)
		get_parent().position.y = clamp(get_parent().position.y, 0, screenSize.y)
		
		rpc_unreliable("update_position",get_parent().position)
	
remote func update_position(position):
	get_parent().position = position
	
