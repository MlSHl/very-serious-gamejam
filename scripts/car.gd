extends CharacterBody3D

@export var car_speed := 10.0
@export var max_lifecycle := 8.0

var lifecycle := 0.0

func _physics_process(delta: float) -> void:
	lifecycle += delta
	if lifecycle >= max_lifecycle:
		queue_free()
		return
	
	velocity = global_transform.basis.z * car_speed
	
	move_and_slide()
