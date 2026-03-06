class_name TwoWayGate
extends ConditionalWater

@export var left_open: bool
@export var right_open: bool

@export var left_visual: CSGMesh3D
@export var right_visual: CSGMesh3D

func toggle() -> void:
	left_open = not left_open
	right_open = not right_open
	propagate_water_downstream()

func propagate_water_downstream() -> void:
	left_visual.visible = left_open
	right_visual.visible = right_open
	downstream[0].flowing = flowing and right_open
	downstream[1].flowing = flowing and left_open
