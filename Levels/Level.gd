class_name Level
extends Node3D

func _ready() -> void:
	Gui.ninfa_gui_menu_active.connect(_on_menu_menu_active_changed)
	get_tree().paused = Gui.state == NINFA_GUI.STATES.MAIN_MENU
	
func _on_menu_menu_active_changed(menu_active:bool) -> void:
	get_tree().paused = menu_active
