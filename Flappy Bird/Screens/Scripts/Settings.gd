extends Node2D

signal screen_closed

onready var platform_settings = {
	"Android": $UI/AndroidSettings,
	"Windows": $UI/AndroidSettings,
}

func _ready() -> void:
	load_settings()
	if OS.get_name() in platform_settings:
		platform_settings[OS.get_name()].visible = true

func load_settings():
	$UI/AndroidSettings/chkbtnJumpOnRelease.pressed = PlayerStats.jump_on_release

func apply_changes():
	PlayerStats.jump_on_release = $UI/AndroidSettings/chkbtnJumpOnRelease.pressed

func _on_btnMenu_pressed() -> void:
	apply_changes()
	FileIO.save_file()
	emit_signal("screen_closed")


func _on_btnCancel_pressed() -> void:
	emit_signal("screen_closed")