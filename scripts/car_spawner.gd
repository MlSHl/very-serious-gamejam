extends Node3D

@export var scenes: Array[PackedScene]
@export var spawn_vec_1: Vector3
@export var spawn_interval := 2.0

var spawn_timer := 0.0

func _ready() -> void:
	spawn_car()

func _process(delta: float) -> void:
	spawn_timer+=delta
	if spawn_timer >= spawn_interval:
		spawn_timer = 0
		spawn_car()
		
func spawn_car() -> void:
	print("TRYING TO SPAWN NODE")
	if scenes == null:
		print("FATAL: no scenes chosen for spawner")
		return
	
	var scene_to_spawn = scenes.pick_random().instantiate() as CharacterBody3D

	get_tree().current_scene.add_child(scene_to_spawn)
	
	scene_to_spawn.global_position = position + spawn_vec_1
	scene_to_spawn.global_basis = global_basis
	
func get_random_color() -> Color:
	return Color(randf(), randf(), randf())
