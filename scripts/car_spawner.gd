extends Node3D

@export var car_scene: PackedScene
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
	print("TRYING TO SPAWN CAR")
	if car_scene == null:
		print("FATAL: no car scene chosen for spawner")
		return
	
	var car1 = car_scene.instantiate() as CharacterBody3D
	
	
	get_tree().current_scene.add_child(car1)
	
	car1.global_position = position + spawn_vec_1
	car1.global_basis = global_basis
	
