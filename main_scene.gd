extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Retry.hide()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_game_timer_timeout():
	
	$Control/Retry.show()
	#letter.queue_free()
