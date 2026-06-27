extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	AudioController.running_song_2.play()
	await AudioController.running_song_2.finished
	AudioController.running_song_1.play()
	await AudioController.running_song_1.finished
	AudioController.running_song_3.play()
	await AudioController.running_song_3.finished 
	AudioController.running_song_4_with.play()
	await AudioController.running_song_4_with.finished


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_winzone_body_entered(body: Node3D) -> void:
	#AudioController.
	#get_tree().change_scene_to_file("res://scenes/winscreen.tscn")
	get_tree().call_deferred("change_scene_to_file","res://scenes/winscreen.tscn")
	AudioController._stop_playing_music()


func _on_killzone_body_entered(body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file","res://scenes/deathscreen.tscn")
	AudioController._stop_playing_music()
