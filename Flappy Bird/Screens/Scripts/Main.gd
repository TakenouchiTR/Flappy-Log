extends Node2D

const GAME = preload("res://Screens/Game.tscn")
const MENU = preload("res://Screens/Menu.tscn")
const SETTINGS = preload("res://Screens/Settings.tscn")
const STORE = preload("res://Screens/Store.tscn")

var current_screen

func _ready() -> void:
	FileIO.load_file()
	load_menu()

func load_menu():
	current_screen = MENU.instantiate()
	add_child(current_screen)
	current_screen.connect("start_pressed", Callable(self, "on_menu_start_pressed"))
	current_screen.connect("settings_pressed", Callable(self, "on_menu_settings_pressed"))
	current_screen.connect("store_pressed", Callable(self, "on_menu_store_pressed"))

func load_settings():
	current_screen = SETTINGS.instantiate()
	add_child(current_screen)
	current_screen.connect("screen_closed", Callable(self, "on_settings_screen_closed"))

func load_game():
	current_screen = GAME.instantiate()
	add_child(current_screen)
	current_screen.connect("game_ended", Callable(self, "on_game_ended"))
	current_screen.connect("game_restarted", Callable(self, "on_game_restarted"))

func load_store():
	current_screen = STORE.instantiate()
	add_child(current_screen)
	current_screen.connect("store_closed", Callable(self, "on_store_closed"))

func on_menu_start_pressed():
	current_screen.queue_free()
	load_game()

func on_menu_settings_pressed():
	current_screen.queue_free()
	load_settings()

func on_menu_store_pressed():
	current_screen.queue_free()
	load_store()

func on_game_ended():
	current_screen.queue_free()
	load_menu()

func on_game_restarted():
	current_screen.queue_free()
	load_game()

func on_settings_screen_closed():
	current_screen.queue_free()
	load_menu()

func on_store_closed():
	current_screen.queue_free()
	load_menu()
