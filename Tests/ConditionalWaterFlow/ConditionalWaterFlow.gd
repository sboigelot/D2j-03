extends Node3D

@export var source_water: ConditionalWater
@export var two_way_gate: TwoWayGate

@onready var check_button: CheckButton = $PanelContainer/VBoxContainer/CheckButton
@onready var check_button_2: CheckButton = $PanelContainer/VBoxContainer/CheckButton2

func _ready() -> void:
	check_button.set_pressed_no_signal(source_water.flowing)
	check_button.toggled.connect(_on_check_button_toggled)
	check_button_2.set_pressed_no_signal(two_way_gate.left_open)
	check_button_2.toggled.connect(_on_check_2_button_toggled)

func _on_check_button_toggled(toggled_on: bool) -> void:
	source_water.flowing = toggled_on
	
func _on_check_2_button_toggled(toggled_on: bool) -> void:
	two_way_gate.toggle()
