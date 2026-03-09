extends MarginContainer


@onready var master_bus_id = AudioServer.get_bus_index("Master")
@onready var music_bus_id = AudioServer.get_bus_index("Music")
@onready var sfx_bus_id = AudioServer.get_bus_index("SFX")
