extends Control


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game_screens/main_screen.tscn")
	print("Starting game")
