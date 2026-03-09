class_name FullscreenHelper
extends Node

static func is_fullscreen() -> bool:
	var current_mode = DisplayServer.window_get_mode()
	var fullscreen = current_mode == DisplayServer.WINDOW_MODE_FULLSCREEN
	return fullscreen

static func exit_fullscreen_mode():
	var current_mode = DisplayServer.window_get_mode()
	if current_mode != DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
static func toggle_fullscreen_mode():
	if is_fullscreen():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)	
