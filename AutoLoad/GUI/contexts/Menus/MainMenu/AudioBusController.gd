extends HBoxContainer

@export_enum("Master", "Music", "SFX") var bus_name:String = "Master"

@onready var check_box: CheckBox = $CheckBox
@onready var h_slider: HSlider = $HSlider
@onready var bus_id:int = AudioServer.get_bus_index(bus_name)

func _ready() -> void:
	
	check_box.toggled.connect(_on_check_box_toggled)
	h_slider.drag_ended.connect(_on_h_slider_drag_ended)
	
	check_box.set_pressed_no_signal(not AudioServer.is_bus_mute(bus_id))
	var audio_volume = AudioServer.get_bus_volume_linear(bus_id)
	h_slider.set_value_no_signal(audio_volume)

func _on_check_box_toggled(toggled_on:bool) -> void:
	AudioServer.set_bus_mute(bus_id, not toggled_on)
	
func _on_h_slider_drag_ended(value_changed:bool) -> void:
	if value_changed:
		var value = h_slider.value
		AudioServer.set_bus_volume_linear(bus_id, value)
		SfxManager.play("drop_003")
		
