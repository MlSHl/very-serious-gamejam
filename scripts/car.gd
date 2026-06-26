extends CharacterBody3D

@export var car_speed := 10.0
@export var max_lifecycle := 8.0
@onready var car_chasis: MeshInstance3D = $"car-taxi-v3/car_chasis"

var lifecycle := 0.0

func _ready() -> void:
	var base_color := Color(randf(), randf(), randf())
	var dark_color := base_color.darkened(0.2)
	var material = car_chasis.get_active_material(0).duplicate()
	material.set_shader_parameter("car_color", base_color)
	material.set_shader_parameter("car_color_dark", dark_color)
	car_chasis.set_surface_override_material(0, material)

func _physics_process(delta: float) -> void:
	lifecycle += delta
	if lifecycle >= max_lifecycle:
		queue_free()
		return
	
	velocity = global_transform.basis.z * car_speed
	
	move_and_slide()
