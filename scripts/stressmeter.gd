extends Control
@onready var spriteholder: NinePatchRect = $CanvasLayer/spriteholder
@onready var stresslevel_0: Sprite2D = $CanvasLayer/spriteholder/stresslevel0
@onready var lvl_0: Sprite2D = $CanvasLayer/spriteholder/stresslevel0/lvl0
@onready var stresslevel_1: Sprite2D = $CanvasLayer/spriteholder/stresslevel1
@onready var lvl_1: Sprite2D = $CanvasLayer/spriteholder/stresslevel1/lvl1
@onready var stresslevel_2: Sprite2D = $CanvasLayer/spriteholder/stresslevel2
@onready var lvl_2: Sprite2D = $CanvasLayer/spriteholder/stresslevel2/lvl2
@onready var stresslevel_3: Sprite2D = $CanvasLayer/spriteholder/stresslevel3
@onready var lvl_3: Sprite2D = $CanvasLayer/spriteholder/stresslevel3/lvl3
@onready var stresslevel_4: Sprite2D = $CanvasLayer/spriteholder/stresslevel4
@onready var lvl_4: Sprite2D = $CanvasLayer/spriteholder/stresslevel4/lvl4

var R: float = 0.0
var G: float = 1.0
var B: float = 0.33
var stress_level: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spriteholder.visible = true
	print(R," ",G," " ,B," ",stress_level)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if stress_level < 20:
		stresslevel_0.show()
	elif stress_level > 19 and stress_level < 40:
		stresslevel_1.show()
		stresslevel_0.hide()
	elif stress_level > 39 and stress_level < 60:
		stresslevel_2.show()
		stresslevel_1.hide()
	elif stress_level > 59 and stress_level < 80:
		stresslevel_3.show()
		stresslevel_2.hide()
	elif stress_level > 79:
		stresslevel_4.show()
		stresslevel_3.hide()
	
	R = 0.0 + stress_level * 1.01
	G = 1.0 - stress_level * 0.01
	B = 0.33 - stress_level / 0.003
	
	spriteholder.modulate = Color(R,G,B,1.0)
	
	
	
	
	
	
	
	
	
