extends CharacterBody3D


const SPEED = 25.0
const ROTATION_SPEED = 2.5
const ROLLING_SPEED = 25.0
const MAX_CAMERA_DELTA := 0.6

var camera_delta := 0.0

@onready var camera: Camera3D = $Camera3D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Turning left/right
	var input_dir := Input.get_axis("left", "right")
	rotation.y += -input_dir * ROTATION_SPEED * delta
	if input_dir:
		if abs(camera_delta) < MAX_CAMERA_DELTA:
			camera_delta += input_dir * delta
			camera.position.x += delta * input_dir
	else:
		if abs(camera_delta) > 0:
			camera_delta += -sign(camera_delta) * delta
			camera.position.x -= delta * sign(camera_delta)
			if abs(camera_delta) <= 0.01:
				camera_delta = 0
		
		
	# Constant foward velocity
	var forward := -transform.basis.z
	forward = forward.normalized()
	$wheel.rotate_x(-ROLLING_SPEED * delta)
	
	velocity.x = forward.x * SPEED
	velocity.z = forward.z * SPEED 

	move_and_slide()
