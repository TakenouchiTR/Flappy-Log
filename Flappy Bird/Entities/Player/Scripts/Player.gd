extends CharacterBody2D

var perform_jump := false
var is_active := true

@export var gravity := 320
@export var jump_strength := -200
@export var max_speed := 512

@onready var sprite := $Sprite2D
@onready var jump_player := $JumpAudioPlayer

func set_skin(skin):
	sprite.set_skin(skin)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() or PlayerStats.jump_on_release:
			perform_jump = true

func _apply_gravity(delta: float):
	velocity.y += gravity * delta
	velocity.y = min(max_speed, velocity.y)

func move():
	set_velocity(velocity)
	move_and_slide()
	velocity = velocity
	
	if velocity.y < 0:
		sprite.rotation_degrees = 90 * velocity.y / 256
	else:
		sprite.rotation_degrees = 90 * velocity.y / 400
		sprite.rotation_degrees = min(90, sprite.rotation_degrees)

func process_input():
	perform_jump = perform_jump or Input.is_action_just_pressed("flap")
	if perform_jump:
		velocity.y = jump_strength
		jump_player.play()
	perform_jump = false

func handle_active(delta: float):
	_apply_gravity(delta)
	process_input()
	move()

func _process(delta: float) -> void:
	if not is_active:
		return
	
	handle_active(delta)
