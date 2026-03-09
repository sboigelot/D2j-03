class_name Level
extends Node3D

@export var control_info: Node3D
@export var tvui: TvUi
@export var plants_placeholder: Node3D

func _ready() -> void:
	Gui.ninfa_gui_menu_active.connect(_on_menu_menu_active_changed)
	set_pause(Gui.state == NINFA_GUI.STATES.MAIN_MENU)
	update_irrigation_progress()
	
func _on_menu_menu_active_changed(menu_active:bool) -> void:
	set_pause(menu_active)
	
func set_pause(paused) -> void:
	control_info.visible = not paused
	#get_tree().paused = paused
	
func update_irrigation_progress() -> void:
	var max_plants = plants_placeholder.get_child_count()
	var irrigated_plants = plants_placeholder.get_children()\
									.filter(
										func(plant:Plant3D): return plant.irrigated
									)\
									.size()
	
	tvui.irrigated_progress_bar.max_value = max_plants
	tvui.irrigated_progress_bar.value = irrigated_plants
	
	if irrigated_plants >= max_plants:
		victory()
		
func victory():
	pass
