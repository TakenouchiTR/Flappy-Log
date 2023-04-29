extends Sprite

const GRAVITY = 320
const MOVE_SPEED = 128

var velocity = Vector2(MOVE_SPEED, 0)
var rotation_offset = 0

func _process(delta: float) -> void:
	position += velocity * delta
	velocity.y += GRAVITY * delta
	
	if velocity.y < 0:
		rotation_degrees = 90 * (velocity.y + rotation_offset) / 256
	else:
		rotation_degrees = 90 * (velocity.y + rotation_offset) / 400
