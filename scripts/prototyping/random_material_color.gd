extends Node

func _ready() -> void:
	for child in get_children():
		if child is CSGBox3D:
			var mat = StandardMaterial3D.new()
			mat.albedo_color = get_rand_color()
			child.material = mat

func get_random_color() -> float:
	return randf_range(0.4, 1.0)

func get_rand_color() -> Color:
	return Color(get_random_color(), get_random_color(), get_random_color())
