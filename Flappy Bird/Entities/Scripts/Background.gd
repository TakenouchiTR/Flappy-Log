extends Node2D

onready var sprite = $Sprite

var moving = true

func _process(delta: float) -> void:
	if not moving:
		return

	position.x -= 24 * delta
	if position.x < -sprite.texture.get_width() * sprite.scale.x:
		position.x += sprite.texture.get_width() * sprite.scale.x
