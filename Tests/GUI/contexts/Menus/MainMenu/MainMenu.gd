extends NinfaMenu

@onready var _buttonReferences : Dictionary = {
	"start": {
		"reference": $hpos/vpos/rootButtons/bg/vpos/start,
		"callback": _on_start_button_pressed
	},
	"exit": {
		"reference": $hpos/vpos/rootButtons/bg/vpos/exit,
		"callback": _on_exit_button_pressed
	}
}

func _on_start_button_pressed() -> void:
	print("Start button pressed")
	emit_signal("gui_fsm_request", self, NINFA_GUI.ACTIONS.START_GAME)

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func hide_transition() -> void:
	super.hide_transition()
			
	# self._tween.tween_property(self, "position", Vector2(2400, self.position.y), 5)
	self._tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1)
	self._tween.set_trans(Tween.TRANS_CUBIC)
	self._tween.set_ease(Tween.EASE_IN)


func _ready() -> void:
	# DESCRIPTION: Remove exit button in web export
	if OS.has_feature("web"):
		_buttonReferences.exit.reference.queue_free()
		_buttonReferences.erase("exit")

	for _key in self._buttonReferences.keys():
		self._buttonReferences[_key].reference.initialize(
			self._buttonReferences[_key].callback
		)
