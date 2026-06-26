extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
#	SceneTransition._fade_from_white()
	pass	
	
	
	AudioController.running_song_1.play()
	AudioController.running_song_1.stop()
	
	AudioController.glass_shatter.play()
	





# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
