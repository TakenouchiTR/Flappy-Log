extends Node2D

const _MENU = preload("res://Screens/Menu.tscn")
var current_screen

func _ready() -> void:
	PlayerIO.load_file()
	SkinIO.load_file()
	load_screen(_MENU.instantiate())

func load_screen(screen: Node):
	if current_screen != null:
		current_screen.queue_free()

	current_screen = screen
	screen.screen_closed.connect(load_screen)
	add_child(current_screen)
