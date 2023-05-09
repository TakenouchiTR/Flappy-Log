extends Node

signal screen_closed

func close_screen(next_screen):
	screen_closed.emit(next_screen)
