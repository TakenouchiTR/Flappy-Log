extends Node2D

signal score_area_entered
signal kill_area_entered

const _DELETE_THRESHOLD = -240

## How much the obstacle can vary in height from the center, in pixels.
@export var y_range := 150

## How quickly the obstacle moves to the right, in pixels per second.
@export var move_speed := 128.0

## How much to offset the obstacle from the center, in pixels
@export var center_offset := 0.0

var _current_move_speed = move_speed

func _ready() -> void:
	randomize_height()

func stop_movement():
	_current_move_speed = 0

func _process(delta: float) -> void:
	position.x -= _current_move_speed * delta
	if position.x < _DELETE_THRESHOLD:
		queue_free()

func randomize_height():
	var center_height := DisplayServer.screen_get_size().y / 4.0
	position.y = randi() % (y_range * 2) - y_range + center_height + center_offset

# warning-ignore:unused_argument
func _on_ScoreTrigger_area_entered(_area: Area2D) -> void:
	score_area_entered.emit()

# warning-ignore:unused_argument
func _on_KillBox_area_entered(_area: Area2D) -> void:
	kill_area_entered.emit()
