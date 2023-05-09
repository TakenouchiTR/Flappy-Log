extends Sprite2D

func set_skin(skin):
	var palette = skin.to_color_palette()
	for i in range(len(palette)):
		var color = palette[i]
		material.set("shader_parameter/color" + str(i), color)
	
	texture = load("res://Sprites/Player/Player_" + str(skin.sprite_number) + "_base.png")
