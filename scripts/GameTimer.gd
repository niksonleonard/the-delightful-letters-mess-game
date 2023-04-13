extends Timer
@export var hourlass: Label

func _process(_delta):
	# The Timer node already has an property named "time_left" we can only get 
	# the Integer part of it value and set it to or Countdown Label =]
	hourlass.text = str(int(time_left))
