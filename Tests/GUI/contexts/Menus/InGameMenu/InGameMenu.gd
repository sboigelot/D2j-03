extends NinfaMenu

var _inputProcessingAllowed : bool = false

###############################################################################
###############################################################################
## SECTION: Private Member Variables ##########################################
###############################################################################
###############################################################################
@onready var _buttonReferences : Dictionary = {
	"exit_to_main_menu": {
		"reference": $PanelContainer/VBoxContainer/returnToMainMenu,
		"callback": _on_exit_to_main_menu_button_pressed
	},
	"exit_to_system": {
		"reference": $PanelContainer/VBoxContainer/exitToSystem,
		"callback": _on_exit_to_system_button_pressed
	}
}

func reveal_transition() -> void:
	self.visible = true
	super.reveal_transition()

	self._tween.tween_property(self, "modulate", Color(1, 1, 1, 1), 0.5)
	self._tween.set_trans(Tween.TRANS_CUBIC)
	self._tween.set_ease(Tween.EASE_IN_OUT)

	await self._tween.finished

func hide_transition() -> void:
	super.hide_transition()
			
	self._tween.tween_property(self, "modulate", Color(1, 1, 1, 0), 1)
	self._tween.set_trans(Tween.TRANS_CUBIC)
	self._tween.set_ease(Tween.EASE_IN)

	await self._tween.finished
	self.visible = false

func enable_input_processing() -> void:
	self._inputProcessingAllowed = true

func disable_input_processing() -> void:
	self._inputProcessingAllowed = false

###############################################################################
###############################################################################
## SECTION: Signal Handling ###################################################
###############################################################################
###############################################################################
func _on_exit_to_main_menu_button_pressed() -> void:
	emit_signal(
		"ninfa_gui_fsm_request", self, NINFA_GUI.ACTIONS.RETURN_TO_MAIN_MENU
	)

func _on_exit_to_system_button_pressed() -> void:
	get_tree().quit()

###############################################################################
###############################################################################
## SECTION: Godot Loadtime Function Overrides #################################
###############################################################################
###############################################################################
func _ready() -> void:
	# DESCRIPTION: Remove exit to system button in web export
	if OS.has_feature("web"):
		self._buttonReferences.exit_to_system.reference.queue_free()
		self._buttonReferences.erase("exit_to_system")

	for _key in self._buttonReferences.keys():
		self._buttonReferences[_key].reference.initialize(
			self._buttonReferences[_key].callback
		)

	self.visible = false

###############################################################################
###############################################################################
## SECTION: Godot Runtime Function Overrides ##################################
###############################################################################
###############################################################################
func _process(delta : float) -> void:
	if self._inputProcessingAllowed:
		if Input.is_action_just_pressed("ui_cancel"):
			print("UI cancel")
			if self.visible:
				emit_signal("ninfa_gui_fsm_request", self, NINFA_GUI.ACTIONS.HIDE_INGAME_MENU)

			else:
				emit_signal("ninfa_gui_fsm_request", self, NINFA_GUI.ACTIONS.REVEAL_INGAME_MENU)
