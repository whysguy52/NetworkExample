extends Label

export var defaultColor : Color = Color.mediumblue
export var hoverColor : Color = Color.green

func _ready():
	set("custom_colors/font_color", defaultColor)
	pass
	
func _on_mouse_entered():
	set("custom_colors/font_color", hoverColor)

func _on_mouse_exited():
	set("custom_colors/font_color", defaultColor)
