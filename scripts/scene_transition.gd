extends CanvasLayer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var color_rect: ColorRect = $ColorRect

	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.hide()

func _fade_to_white():
	color_rect.show()
	animation_player.play("fade_to_white")
	await animation_player.animation_finished
	color_rect.hide()
	

func _fade_from_white():
	color_rect.show()
	animation_player.play("fade_from_white")
	await animation_player.animation_finished
	color_rect.hide()
	
