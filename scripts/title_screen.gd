extends Control

@export var bgMusic: AudioStreamPlayer2D

func _on_button_startgame_pressed():
	bgMusic.stop()
	get_tree().change_scene_to_file("res://scenes/game_screens/main_screen.tscn")
	print("Starting game")

func _on_button_album_pressed():
	bgMusic.stop()
	get_tree().change_scene_to_file("res://scenes/game_screens/stamp_album_screen.tscn")
	print("Album screen")
