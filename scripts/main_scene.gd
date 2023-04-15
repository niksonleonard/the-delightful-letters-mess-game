extends Node3D

@onready var gameSession: GameSessionState = get_node("/root/GameSession")
@export var scoreLabel: Label
@export var finalScore: Label
@export var holdingLetterTexture: TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	gameSession.reset_gamedata()
	gameSession.score_changed.connect(update_label)
	gameSession.letter_picked.connect(show_letter_indicator)
	gameSession.letter_dellivered.connect(hide_letter_indicator)

func show_letter_indicator():
	holdingLetterTexture.visible = true

func hide_letter_indicator():
	holdingLetterTexture.visible = false

func update_label():
	scoreLabel.text = "Pontos:" + str(gameSession.score)

func _on_game_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/game_screens/game_result_screen.tscn")

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		restart_the_game()

func restart_the_game():
	# This restarts the current scene.
	get_tree().reload_current_scene()
	gameSession.score = 0
