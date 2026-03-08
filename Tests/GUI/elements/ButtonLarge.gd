extends Button

func _on_mouse_entered() -> void:
	SfxManager.play("drop_003")

func _on_pressed() -> void:
	SfxManager.play("switch_005")

func initialize(a_callback) -> void:
	# DESCRIPTION: Add custom callback for button press
	if a_callback != null:
		self.pressed.connect(a_callback)

func _ready() -> void:
	# DESCRIPTION: Signal management
	self.mouse_entered.connect(_on_mouse_entered)
	self.pressed.connect(_on_pressed)
	
	
