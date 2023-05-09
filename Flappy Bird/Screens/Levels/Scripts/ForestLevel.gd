extends "res://Screens/Scripts/Screen.gd"

const FRONT_LOG_HALF := preload("res://Entities/Front Log Half.tscn")
const BACK_LOG_HALF := preload("res://Entities/Back Log Half.tscn")
const _OBSTACLE := preload("res://Entities/Obstacles/ChainsawObstacle.tscn")
const _INITIAL_OBSTACLE_X := 720

@onready var lbl_score := $lblScore
@onready var player := $Player
var score = 0

func _ready():
	player.set_skin(Skins.skins[PlayerStats.selected_skin])
	_create_obstacle()

func _create_obstacle():
	var obstacle := _OBSTACLE.instantiate()
	obstacle.connect("score_area_entered", _on_Obstacle_score_area_entered)
	obstacle.connect("kill_area_entered", _on_Obstacle_kill_area_entered)
	
	$Obstacles.add_child(obstacle)
	obstacle.position.x = _INITIAL_OBSTACLE_X

func _update_stats():
	PlayerStats.points += score
	PlayerStats.high_scores[1] = max(PlayerStats.high_scores[1], score)

func _on_Obstacle_score_area_entered() -> void:
	score += 1
	lbl_score.text = "Score: " + str(score)

func _on_Obstacle_kill_area_entered(_area = null) -> void:
	_update_stats()
	PlayerIO.save_file()
	
	var front_log = FRONT_LOG_HALF.instantiate()
	var back_log = BACK_LOG_HALF.instantiate()
	
	back_log.velocity.y = player.velocity.y - 32 
	back_log.rotation_offset = 32
	front_log.velocity.y = player.velocity.y
	front_log.velocity.x += 16
	
	if player.velocity.y > 400:
		front_log.rotation_offset -= player.velocity.y - 400
		back_log.rotation_offset -= player.velocity.y - 400
	
	add_child(front_log)
	add_child(back_log)
	
	move_child(front_log, 3)
	move_child(back_log, 1)
	
	front_log.position = player.position
	back_log.position = player.position
	
	player.queue_free()
	
	$ObstacleTimer.stop()
	for obstacle in $Obstacles.get_children():
		obstacle.stop_movement()
	$Background.moving = false
	$btnReturn.visible = true
	$btnRestart.visible = true

func _on_btnReturn_pressed() -> void:
	screen_closed.emit(load("res://Screens/LevelSelect.tscn").instantiate())

func _on_btnRestart_pressed() -> void:
	screen_closed.emit(load("res://Screens/Levels/ForestLevel.tscn").instantiate())

func _on_obstacle_timer_timeout():
	_create_obstacle()
