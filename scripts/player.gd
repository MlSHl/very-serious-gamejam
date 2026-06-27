extends CharacterBody3D


const SPEED = 15.0
const ROTATION_SPEED = 4.0
const ROLLING_SPEED = 30.0
const MAX_CAMERA_DELTA_X := 0.1
const MAX_CAMERA_DELTA_Y := 0.4
const MAX_HAMSTER_DISPLACEMENT_X := 0.03
const DELTA_HAMSTER_DISPLACEMENT_X := 0.2
const MAX_HAMSTER_CHANGE := 0.25
const HAMSTER_LEN_CHANGE_SPEED := 10
const STRESS_DELTA := 5

var camera_delta_x := 0.0
var camera_delta_y := 0.0
var hamster_len_change_sign := 1

@onready var camera: Camera3D = $Camera3D
@onready var camera_x := camera.position.x
@onready var camera_y := camera.position.y
@onready var hamster: Node3D = $hamster 
@onready var hamster_x := hamster.position.x
@onready var hamster_scale_z := hamster.scale.z

@export var gravity_multiplier := 2.0

@onready var stressmeter = $stressmeter

func _physics_process(delta: float) -> void:
	account_for_gravity(delta);
	account_for_turning(delta);
	move_forward(delta);

	move_and_slide()

func account_for_gravity(delta: float):
	if not is_on_floor():
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

func account_for_turning(delta: float):
	var input_dir := Input.get_axis("left", "right")
	var hamster_delta = hamster.position.x - hamster_x
	if input_dir:
		stressmeter.stress_level+=delta * STRESS_DELTA
		if abs(hamster_delta) < MAX_HAMSTER_DISPLACEMENT_X:
			hamster.position.x += delta * DELTA_HAMSTER_DISPLACEMENT_X * input_dir
		else:
			if abs(camera_delta_x) < MAX_CAMERA_DELTA_X:
				camera_delta_x += 	input_dir * delta
				camera.position.x = camera_x + camera_delta_x 
			rotation.y += -input_dir * ROTATION_SPEED * delta
	else:
		if abs(hamster_delta) > MAX_HAMSTER_DISPLACEMENT_X:
			hamster.position.x -= delta * sign(hamster_delta) * DELTA_HAMSTER_DISPLACEMENT_X
		else: 
			hamster.position.x = hamster_x
		if abs(camera_delta_x) > 0:
			camera_delta_x -= sign(camera_delta_x) * delta
			camera.position.x = camera_x + camera_delta_x
			if abs(camera_delta_x) <= 0.01:
				camera_delta_x = 0
				
func move_forward(delta: float):
	var forward := -transform.basis.z
	forward = forward.normalized()
	$wheel.rotate_x(-ROLLING_SPEED * delta)
	var delta_hamster_len :=  hamster.scale.z - hamster_scale_z
	if abs(delta_hamster_len) >= MAX_HAMSTER_CHANGE:
		hamster_len_change_sign *= -1
	hamster.scale.z += 	hamster_len_change_sign * delta * HAMSTER_LEN_CHANGE_SPEED
	if is_on_floor():
		var floor_normal := get_floor_normal()

		# Project forward movement onto the ramp/floor surface.
		var ramp_forward := forward.slide(floor_normal).normalized()

		velocity = ramp_forward * SPEED
	else:
		velocity.x = forward.x * SPEED
		velocity.z = forward.z * SPEED 
