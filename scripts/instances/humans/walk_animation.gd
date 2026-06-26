extends CharacterBody3D

@export var car_speed := 3.0
@export var max_lifecycle := 16.0

@onready var man_animation_player: AnimationPlayer = $man_01/AnimationPlayer
@onready var woman_animation_player: AnimationPlayer = $woman_01/AnimationPlayer

var lifecycle := 0.0

func _ready() -> void:
	if (man_animation_player != null):
		man_animation_player.play("walk")
	else:
		woman_animation_player.play("walk")

func _physics_process(delta: float) -> void:
	lifecycle += delta
	if lifecycle >= max_lifecycle:
		queue_free()
		return
	
	velocity = global_transform.basis.z * car_speed
	
	move_and_slide()
