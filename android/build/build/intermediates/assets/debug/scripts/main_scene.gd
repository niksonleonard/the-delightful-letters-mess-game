extends Node3D

@onready var gameSession: GameSessionState = get_node("/root/GameSession")
@export var scoreLabel: Label
@export var finalScore: Label
@export var holdingLetterTexture: TextureRect

@export var tutorialScreen: Control
@export var gameTutorial: bool = true


# Called when the node enters the scene tree for the first time.
func _ready():
	gameSession.reset_gamedata()
	gameSession.score_changed.connect(update_label)
	gameSession.letter_picked.connect(show_letter_indicator)
	gameSession.letter_dellivered.connect(hide_letter_indicator)

	if gameSession.playerData.tutorialCompletedTimes >= \
		PlayerData.PLAYERDATA_REQUIRED_TUTORIAL:
			gameTutorial = false
			_hide_tutorial()

func show_letter_indicator():
	holdingLetterTexture.visible = true

func hide_letter_indicator():
	holdingLetterTexture.visible = false

func update_label():
	scoreLabel.text = "Pontos:" + str(gameSession.score)

func _on_game_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/game_screens/game_result_screen.tscn")

func _input(event):
	if gameTutorial and event.is_action_pressed("PointClick"):
		_hide_tutorial()
		gameSession.tutorial_done()

func _show_tutorial():
	tutorialScreen.visible = true

func _hide_tutorial():
	tutorialScreen.visible =  false
