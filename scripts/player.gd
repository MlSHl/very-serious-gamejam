extends CharacterBody3D


const SPEED = 10.0
const ROTATION_SPEED = 4.0
const ROLLING_SPEED = 10.0
const MAX_CAMERA_DELTA_X := 0.1
const MAX_CAMERA_DELTA_Y := 0.4

var camera_delta_x := 0.0
var camera_delta_y := 0.0
var accumulated_delta := 0.0

@onready var camera: Camera3D = $Camera3D
@onready var camera_x := camera.position.x
@onready var camera_y := camera.position.y
@export var gravity_multiplier := 5.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		accumulated_delta += delta
		velocity += gravity_multiplier * get_gravity() * delta # F/m
		if camera_delta_y < MAX_CAMERA_DELTA_Y: 
			camera_delta_y += delta
			camera.position.y = camera_y + camera_delta_y
	else: 
		if abs(camera_delta_y) > 0:
			camera_delta_y -= sign(camera_delta_y) * delta
			camera.position.y = camera_y + camera_delta_y
			if abs(camera_delta_y) <= 0.01:
				camera_delta_y = 0
		
	# Turning left/right
	var input_dir := Input.get_axis("left", "right")
	rotation.y += -input_dir * ROTATION_SPEED * delta
	if input_dir:
		if abs(camera_delta_x) < MAX_CAMERA_DELTA_X:
			camera_delta_x += 	input_dir * delta
			camera.position.x = camera_x + camera_delta_x 
	else:
		if abs(camera_delta_x) > 0:
			camera_delta_x -= sign(camera_delta_x) * delta
			camera.position.x = camera_x + camera_delta_x
			if abs(camera_delta_x) <= 0.01:
				camera_delta_x = 0
		
	# Constant foward velocity
	var forward := -transform.basis.z
	forward = forward.normalized()
	$wheel.rotate_x(-ROLLING_SPEED * delta)
	
	velocity.x = forward.x * SPEED
	velocity.z = forward.z * SPEED 

	move_and_slide()
