extends Node

@export var rotationSpeed = 60.0

@onready var hamster_wheel_v_1_0: Node3D = $"."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	hamster_wheel_v_1_0.rotate_x(rotationSpeed)
