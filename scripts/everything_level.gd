extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_winzone_body_entered(body: Node3D) -> void:
	#AudioController.
	#get_tree().change_scene_to_file("res://scenes/winscreen.tscn")
	get_tree().call_deferred("change_scene_to_file","res://scenes/winscreen.tscn")


func _on_killzone_body_entered(body: Node3D) -> void:
	get_tree().call_deferred("change_scene_to_file","res://scenes/deathscreen.tscn")
