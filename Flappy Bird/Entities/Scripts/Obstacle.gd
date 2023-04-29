extends Node2D

signal score_area_entered
signal kill_area_entered

const BASE_MOVE_SPEED = 128
const RESET_THRESHOLD = -200
const RESET_POSITION = 1300

var move_speed = BASE_MOVE_SPEED

func _ready() -> void:
	randomize_height()
	$Top/Sprite2D.play()
	$Bottom/Sprite2D.play()
	

func _process(delta: float) -> void:
	position.x -= move_speed * delta
	if position.x < RESET_THRESHOLD:
		position.x = RESET_POSITION
		randomize_height()

func randomize_height():
	position.y = randi() % 300 + 312

# warning-ignore:unused_argument
func _on_ScoreTrigger_area_entered(area: Area2D) -> void:
	emit_signal("score_area_entered")

# warning-ignore:unused_argument
func _on_KillBox_area_entered(area: Area2D) -> void:
	emit_signal("kill_area_entered")
