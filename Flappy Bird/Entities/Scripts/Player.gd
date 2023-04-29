extends KinematicBody2D

const GRAVITY = 320
const FLAP_STRENGTH = -200
const MAX_SPEED = 512

enum State {
	Inactive,
	Active,
	Dying
}

var player_state = State.Active
var velocity = Vector2.ZERO
var perform_jump = false

onready var sprite = $Sprite

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() or PlayerStats.jump_on_release:
			perform_jump = true

func _ready() -> void:
	sprite.texture = load("res://Sprites/Player/Player_" + str(PlayerStats.selected_skin) + ".png")

func apply_gravity(delta: float):
	velocity.y += GRAVITY * delta
	velocity.y = min(MAX_SPEED, velocity.y)

func move():
	velocity = move_and_slide(velocity)
	
	if velocity.y < 0:
		sprite.rotation_degrees = 90 * velocity.y / 256
	else:
		sprite.rotation_degrees = 90 * velocity.y / 400
		sprite.rotation_degrees = min(90, sprite.rotation_degrees)

func process_input():
	perform_jump = perform_jump or Input.is_action_just_pressed("flap")
	if perform_jump:
		velocity.y = FLAP_STRENGTH
	perform_jump = false

func handle_active(delta: float):
	apply_gravity(delta)
	process_input()
	move()

func handle_dying(delta: float):
	apply_gravity(delta)
	move()

func _process(delta: float) -> void:
	match player_state:
		State.Inactive: return
		State.Active: handle_active(delta)
		State.Dying: handle_dying(delta)
