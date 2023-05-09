extends "res://Screens/Scripts/Screen.gd"

@onready var platform_settings = {
	"Android": $UI/AndroidSettings,
	"Windows": $UI/AndroidSettings,
}

func _ready() -> void:
	load_settings()
	if OS.get_name() in platform_settings:
		platform_settings[OS.get_name()].visible = true

func load_settings():
	$UI/AndroidSettings/chkbtnJumpOnRelease.button_pressed = PlayerStats.jump_on_release

func _apply_changes():
	PlayerStats.jump_on_release = $UI/AndroidSettings/chkbtnJumpOnRelease.button_pressed

func _on_btnMenu_pressed() -> void:
	_apply_changes()
	FileIO.save_file()
	screen_closed.emit(load("res://Screens/Menu.tscn").instantiate())


func _on_btnCancel_pressed() -> void:
	screen_closed.emit(load("res://Screens/Menu.tscn").instantiate())
