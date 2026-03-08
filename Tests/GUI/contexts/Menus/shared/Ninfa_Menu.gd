extends Control

class_name NinfaMenu

signal gui_fsm_request

var _tween : Tween

func _tween_initialize() -> void:
    if self._tween != null and self._tween.is_running():
        self._tween.stop()
    
    self._tween = create_tween()

func hide_transition() -> void:
    _tween_initialize()