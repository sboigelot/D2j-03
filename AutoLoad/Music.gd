extends Node

signal MusicStarts

@export var audio:AudioStreamPlayer

@export var auto_play:bool = true
@export var play_on_start:bool = false
@export var playing_index = -1
@export var random:bool = true

@export var current_song_title = ""

var rng = RandomNumberGenerator.new()

var is_playing:bool = false

@export var playlist:Array[AudioStream]

@export var previous_random_picks = []

func _ready():
	rng.randomize()
	audio.finished.connect(on_audio_finished)
	if play_on_start:
		on_audio_finished()
		
func play(music:AudioStream)->void:
	emit_signal("MusicStarts", current_song_title)
	audio.stream = music
	audio.play()
	is_playing = true

func ensure_music_is_playing():
	if not is_playing:
		play_next_music()

func stop()->void:
	if audio.playing:
		audio.stop()
	else:
		on_audio_finished()
	
func on_audio_finished():
	is_playing = false
	if not auto_play:
		return
	play_next_music()
	
func play_next_music():
	if playlist.size() == 0:
		return
	
	is_playing = true
	
	if not random:
		playing_index = (playing_index + 1) % playlist.size()
	else:
		
		var possible_index = []
		for i in range(0, playlist.size()):
			if not previous_random_picks.has(i):
				possible_index.append(i)
				
		if possible_index.size() == 0:
			previous_random_picks.clear()
			possible_index = range(0, playlist.size())
			
		playing_index = possible_index[rng.randi() % possible_index.size()]
		previous_random_picks.append(playing_index)
	
	var audio_stream = playlist[playing_index]
	current_song_title = audio_stream.resource_path.replace("res://Assets/Musics/","").replace("-"," ")

	play(audio_stream)
