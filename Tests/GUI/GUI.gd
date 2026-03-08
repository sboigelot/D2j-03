extends CanvasLayer

var state : int = NINFA_GUI.STATES.MAIN_MENU

@onready var references : Dictionary = {
	str(NINFA_GUI.STATES.MAIN_MENU): $mainMenu,
	str(NINFA_GUI.STATES.INGAME_MENU): $inGameMenu
}

func _gui_fsm(a_sender : Node, a_request : int) -> void:
	var _tmp_actionKey = NINFA_GUI.ACTIONS.find_key(a_request)
	print(
		"Ninfa GUI: Received Request from \"%s\": %s" % [a_sender, _tmp_actionKey]
	)

	match a_request:
		NINFA_GUI.ACTIONS.START_GAME:
			print("Request == Start Game")

			match state:
				NINFA_GUI.STATES.MAIN_MENU:
					self.references[str(NINFA_GUI.STATES.MAIN_MENU)].hide_transition()
					self.state = NINFA_GUI.STATES.GAME


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for _key in self.references.keys():
		self.references[_key].connect("gui_fsm_request", self._gui_fsm)
