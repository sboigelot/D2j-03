class_name ConditionalWater
extends Node3D

@export var always_visible:bool = false
@export var flowing:bool:
	set(value):
		if flowing == value:
			return
		flowing = value
		if animation_player != null:
			visible = true
			NodeHelper.connect_if_not_connected(
				animation_player.animation_finished, 
				func(_animation_name:String):
					visible = flowing or always_visible
					propagate_water_downstream()
			)
			var animation = start_flowing_animation if flowing else stop_flowing_animation
			animation_player.play(animation)
		else:
			visible = flowing or always_visible
			propagate_water_downstream()
	get():
		return flowing
		
@export var animation_player: AnimationPlayer
@export var start_flowing_animation:String = "start_flowing"
@export var stop_flowing_animation:String = "stop_flowing"
		
@export var downstream: Array[ConditionalWater]

func _ready() -> void:
	visible = flowing or always_visible
	propagate_water_downstream()

func propagate_water_downstream() -> void:
	for water:ConditionalWater in downstream:
		water.flowing = flowing
