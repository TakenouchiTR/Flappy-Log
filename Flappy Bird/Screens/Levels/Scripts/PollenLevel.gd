extends "res://Screens/Scripts/Screen.gd"

const _LEAF_OBSTACLE := preload("res://Entities/Obstacles/LeafObstacle.tscn")
const _FLOWER_OBSTACLE := preload("res://Entities/Obstacles/FlowerObstacle.tscn")
const _INITIAL_OBSTACLE_X := 800
const _MIN_FLOWER_INTERVAL := 15
const _MAX_FLOWER_INTERVAL := 25

@onready var lbl_score := $UI/ScoreLabel
@onready var player := $Player

var score = 0
var _next_flower = 5
var _skip_generation = false

func _ready():
	_next_flower = _next_flower_interval()
	_create_obstacle()

func _create_obstacle():
	if _skip_generation:
		_skip_generation = false
		return
	
	_next_flower -= 1
	if _next_flower == 0:
		_create_flower_obstacle()
	else:
		_create_leaf_obstacle()

func _create_flower_obstacle():
	_skip_generation = true
	
	var obstacle := _FLOWER_OBSTACLE.instantiate()
	obstacle.connect("score_area_entered", _on_Obstacle_score_area_entered)
	obstacle.connect("kill_area_entered", _on_Obstacle_kill_area_entered)
	obstacle.connect("flower_entered", _on_obstacle_flower_entered)
	
	_next_flower = _next_flower_interval()
	
	$Obstacles.add_child(obstacle)
	obstacle.position.x = _INITIAL_OBSTACLE_X

func _next_flower_interval() -> int:
	return randi() % (_MAX_FLOWER_INTERVAL - _MIN_FLOWER_INTERVAL) + _MIN_FLOWER_INTERVAL

func _create_leaf_obstacle():
	var obstacle := _LEAF_OBSTACLE.instantiate()
	obstacle.connect("score_area_entered", _on_Obstacle_score_area_entered)
	obstacle.connect("kill_area_entered", _on_Obstacle_kill_area_entered)
	
	$Obstacles.add_child(obstacle)
	obstacle.position.x = _INITIAL_OBSTACLE_X

## Adds the score to the player's points, updates the high score, and unlocks the next level
func _update_stats():
	PlayerStats.points += score
	PlayerStats.high_scores[0] = max(PlayerStats.high_scores[0], score)
	PlayerStats.unlocked_levels[1] = true

## Stops obstacle spawning, obstacle movement, background movement, and makes the UI visible
func _end_game():
	$ObstacleTimer.stop()
	for obstacle in $Obstacles.get_children():
		obstacle.stop_movement()
	$Background.moving = false
	$UI/GameOverMenu.visible = true
	$UI/ScoreLabel.visible = false

func _on_Obstacle_score_area_entered() -> void:
	score += 1
	lbl_score.text = "Score: " + str(score)

func _on_Obstacle_kill_area_entered(_area = null) -> void:
	$UI/GameOverMenu/MessageLabel.text = "No flowers were pollinated.\nYour score was not saved."
	_end_game()
	player.queue_free()

func _on_obstacle_flower_entered(_area = null) -> void:
	$UI/GameOverMenu/MessageLabel.text = "Score: %d" % score
	$UI/GameOverMenu/TitleLabel.text = "Level\nComplete!"
	_update_stats()
	PlayerIO.save_file()
	
	_end_game()
	player.is_active = false

func _on_btnReturn_pressed() -> void:
	screen_closed.emit(load("res://Screens/LevelSelect.tscn").instantiate())

func _on_btnRestart_pressed() -> void:
	screen_closed.emit(load("res://Screens/Levels/PollenLevel.tscn").instantiate())

func _on_obstacle_timer_timeout():
	_create_obstacle()
