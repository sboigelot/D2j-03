extends CanvasLayer

signal ninfa_gui_menu_active

var state : int = NINFA_GUI.STATES.MAIN_MENU

@onready var references : Dictionary = {
	str(NINFA_GUI.STATES.MAIN_MENU): $mainMenu,
	str(NINFA_GUI.STATES.INGAME_MENU): $inGameMenu
}

###############################################################################
###############################################################################
## SECTION: Private Member Functions ##########################################
###############################################################################
###############################################################################
func _gui_fsm(a_sender, a_request) -> void:
	var _tmp_actionKey = NINFA_GUI.ACTIONS.find_key(a_request)
	print(
		"Ninfa GUI: Received Request from \"%s\": %s" % [a_sender, _tmp_actionKey]
	)

	match a_request:
		NINFA_GUI.ACTIONS.START_GAME:
			match state:
				NINFA_GUI.STATES.MAIN_MENU:
					self.references[str(NINFA_GUI.STATES.MAIN_MENU)].hide_transition()
					self.ninfa_gui_menu_active.emit(false)
					self.state = NINFA_GUI.STATES.GAME
					self.references[str(NINFA_GUI.STATES.INGAME_MENU)].enable_input_processing()

		NINFA_GUI.ACTIONS.RETURN_TO_MAIN_MENU:
			self.ninfa_gui_menu_active.emit(true)
			self.references[str(NINFA_GUI.STATES.INGAME_MENU)].disable_input_processing()
			self.references[str(NINFA_GUI.STATES.INGAME_MENU)].hide_transition()
			self.references[str(NINFA_GUI.STATES.MAIN_MENU)].reveal_transition()
			self.state = NINFA_GUI.STATES.MAIN_MENU

		NINFA_GUI.ACTIONS.REVEAL_INGAME_MENU:
			self.ninfa_gui_menu_active.emit(true)
			self.references[str(NINFA_GUI.STATES.INGAME_MENU)].reveal_transition()
			self.state = NINFA_GUI.STATES.INGAME_MENU

		NINFA_GUI.ACTIONS.HIDE_INGAME_MENU:
			self.references[str(NINFA_GUI.STATES.INGAME_MENU)].hide_transition()
			self.state = NINFA_GUI.STATES.GAME
			self.ninfa_gui_menu_active.emit(false)

###############################################################################
###############################################################################
## SECTION: Godot Loadtime Function Overrides #################################
###############################################################################
###############################################################################
func _ready() -> void:
	# DESCRIPTION: Make known that menu is active
	self.ninfa_gui_menu_active.emit(true)

	# DESCRIPTION: Connect to the request signal of all the contexts 
	for _key in self.references.keys():
		self.references[_key].connect("ninfa_gui_fsm_request", self._gui_fsm)
