extends "res://scripts/label_hover.gd"



func _on_BackLabel_gui_input(event):
	if event.is_pressed():
		NetworkManager.disconnect_player()
		get_tree().change_scene("res://scenes/OnlinePlayMenu/OnlinePlayMenu.tscn")
		get_tree().get_root().get_node("LobbyMenu").render_player_list()
