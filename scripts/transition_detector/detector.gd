extends Node

@export var day_night_script: Script

@onready var atmosphere_script = $day_night_controller

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group('Player'):
		if day_night_script != null:
			atmosphere_script._pass_time()
