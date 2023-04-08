extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	$UserInterface/Retry.hide()

func _on_game_timer_timeout():
	$UserInterface/Retry.show()
	print("It is over darling")
	#letter.queue_free()
