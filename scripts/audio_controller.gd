extends Node3D
@onready var fall: AudioStreamPlayer = $fall
@onready var car_crash: AudioStreamPlayer = $"car crash"
@onready var honk_long: AudioStreamPlayer = $"honk long"
@onready var honk_short: AudioStreamPlayer = $"honk short"
@onready var fan_1: AudioStreamPlayer = $fan1
@onready var fan_2: AudioStreamPlayer = $fan2
@onready var fan_3: AudioStreamPlayer = $fan3
@onready var fan_4: AudioStreamPlayer = $fan4
@onready var glass_shatter: AudioStreamPlayer = $"glass shatter"
@onready var hamster_squeak: AudioStreamPlayer = $"hamster squeak"
@onready var metro_arriving: AudioStreamPlayer = $"metro arriving"
@onready var mouseclick_1: AudioStreamPlayer = $mouseclick1
@onready var people_talking: AudioStreamPlayer = $"people talking"
@onready var wheel_roll: AudioStreamPlayer = $"wheel roll"
@onready var street_ambiance: AudioStreamPlayer = $"street ambiance"
@onready var running_song_1: AudioStreamPlayer = $"running song 1"
@onready var running_song_2: AudioStreamPlayer = $"running song 2"
@onready var running_song_3: AudioStreamPlayer = $"running song 3"
@onready var running_song_4_with: AudioStreamPlayer = $"running song 4 with"
@onready var running_song_4_without: AudioStreamPlayer = $"running song 4 without"

func _stop_playing_music():
	running_song_1.stop()
	running_song_2.stop()
	running_song_3.stop()
	running_song_4_with.stop()
	running_song_4_without.stop()
