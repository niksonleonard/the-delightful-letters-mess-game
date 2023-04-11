extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	$UserInterface/Retry.hide()

func _on_game_timer_timeout():
	$UserInterface/Retry.show()
	$Player.queue_free()
	print("It is over darling")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		restart_the_game()

func _input(_event):
	if Input.is_action_just_pressed("PointClick") and $UserInterface/Retry.visible:
		restart_the_game()

func restart_the_game():
	# This restarts the current scene.
	print("Vida que segue")
	get_tree().reload_current_scene()
