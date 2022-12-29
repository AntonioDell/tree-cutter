extends Control



func _on_start_pressed():
	if modulate != Color.WHITE: return
	get_tree().change_scene_to_file("res://world.tscn")
