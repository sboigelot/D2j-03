class_name ConditionalWater
extends Node3D

@export var always_visible:bool = false
@export var always_flowing:bool = false
@export var flowing:bool:
	set(value):
		flowing = always_flowing or value
		visible = always_visible or flowing
		if animation_player != null:
			var animation = start_flowing_animation if flowing else stop_flowing_animation
			NodeHelper.connect_if_not_connected(
				animation_player.animation_finished, 
				func(_animation_name:String):
					propagate_water_downstream()
			)
			animation_player.play(start_flowing_animation)
		else:
			propagate_water_downstream()
	get():
		return always_flowing or flowing
		
@export var animation_player: AnimationPlayer
@export var start_flowing_animation:String = "start_flowing"
@export var stop_flowing_animation:String = "start_flowing"
		
@export var downstream: Array[ConditionalWater]

func _ready() -> void:
	propagate_water_downstream()

func propagate_water_downstream() -> void:
	for water:ConditionalWater in downstream:
		water.flowing = flowing
