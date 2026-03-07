extends Node3D

###############################################################################
###############################################################################
## SECTION: Export Variables ##################################################
###############################################################################
###############################################################################
@export_category("Camera Position")
@export var pivot_point : Vector3 = Vector3(0, 0, 0)
@export_range(0, 100, 0.01, "suffix:m") var radial_offset : float = 12
@export_range(0, 100, 0.01, "suffix:m") var vertical_offset : float = 4
@export_range(-90, 0, 0.01, "radians_as_degrees") var tilt : float = 0

@export_category("Camera Zoom")
@export_range(0, 10, 0.1, "suffix:m") var ortho_scale_min : float = 0.1
@export_range(0, 100, 0.1, "suffix:m") var ortho_scale_max : float = 4.0
@export_range(0, 10, 0.1, "suffix:m") var ortho_scale_default : float = 4.0
@export_range(0, 10, 0.1, "suffix:m/s") var zoom_speed : float = 6.0

@export_category("Camera Rotation")
@export var camera_rotation_keyboard_speed:float = 5.0
@export var camera_rotation_mouse_speed:float = 0.5

@onready var _Camera : Camera3D = $Camera3D 

var _mouse_dragged : bool = false
var _lastMousePosition = Vector2(0, 0)

func get_zoom_level() -> float:
	return self._Camera.get_zoom_level()

func get_tilt() -> float:
	return self._Camera.get_tilt()

func _ready() -> void:
	# DESCRIPTION: Pass relevant settings to Camera
	# REMARK: Has to be done with a function, as some properties
	# have stacked value changes and will not update otherwise
	print("Camera Controller: tilt: %s" % [self.tilt])
	self._Camera.initialize(
		{
			"radial_offset": self.radial_offset,
			"vertical_offset": self.vertical_offset,
			"tilt": self.tilt,
			"ortho_scale_min": self.ortho_scale_min,
			"ortho_scale_max": self.ortho_scale_max,
			"ortho_scale_default": self.ortho_scale_default,
		}
	)

func _process(delta : float) -> void:
	_process_zoom(delta)
	_process_rotation(delta)
	
func _process_zoom(delta : float) -> void:
	if Input.is_action_just_pressed("camera_zoom_in"):
		_Camera._ortho_scale_requested -= delta * zoom_speed
		
	if Input.is_action_just_pressed("camera_zoom_out"):
		_Camera._ortho_scale_requested += delta * zoom_speed

	_Camera._manage_zoom(delta)
	
func _process_rotation(delta : float) -> void:
	if Input.is_action_pressed("camera_drag"):
		var mouse_position = get_viewport().get_mouse_position()
		if not _mouse_dragged:
			_mouse_dragged = true
		else:
			var mouse_movement:float = _lastMousePosition.x - mouse_position.x
			rotation.y += delta * mouse_movement * camera_rotation_mouse_speed
			
		_lastMousePosition = mouse_position
		
	if Input.is_action_just_released("camera_drag"):
		_mouse_dragged = false
		
	if Input.is_action_pressed("camera_rotate_clockwise"):
		rotation.y += delta * camera_rotation_keyboard_speed
		
	if Input.is_action_pressed("camera_rotate_counterclockwise"):
		rotation.y -= delta * camera_rotation_keyboard_speed
