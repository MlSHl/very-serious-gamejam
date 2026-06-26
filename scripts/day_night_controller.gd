extends Node3D

enum atmosphere { SUNSET, NIGHT, SUNRISE, DAY }

@export var startAtmosphere: atmosphere = atmosphere.SUNSET
@export var morningColorTop: Color = Color("5897fa")
@export var morningColorHorizon: Color = Color("d3916b")
@export var dayColorTop: Color = Color("1f6ddf")
@export var dayColorHorizon: Color = Color("56a9f5")
@export var afternoonColorTop: Color = Color("3d6fcd")
@export var afternoonColorHorizon: Color = Color("e98174")
@export var nightColorTop: Color = Color("090e14")
@export var nightColorHorizon: Color = Color("010049")
@onready var world_environment: WorldEnvironment = $WorldEnvironment
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var dayColorList: Array
var currentDayState = 0
var durationMultiplier: float = 1.0
var currentAtmosphere: atmosphere
var timesList: Array

func _ready() -> void:
	dayColorList = [
		{"top": morningColorTop, "horizon": morningColorHorizon},
		{"top": nightColorTop, "horizon": nightColorHorizon},
		{"top": morningColorTop, "horizon": morningColorHorizon},
		{"top": dayColorTop, "horizon": dayColorHorizon}
	]
	timesList = [
		{"atmosphere": atmosphere.SUNSET, "time": 6},
		{"atmosphere": atmosphere.NIGHT, "time": 8},
		{"atmosphere": atmosphere.SUNRISE, "time": 18},
		{"atmosphere": atmosphere.DAY, "time": 20}
	]
	currentAtmosphere = startAtmosphere
	_change_duration()
	_set_sun(timesList[currentAtmosphere]["time"])
	_day_change_animation()

func _change_duration():
	animation_player.speed_scale = 1.0

func _set_sun(time: float):
	animation_player.play("day_night")
	animation_player.seek(time)
	animation_player.pause()

func _day_change_animation():
	var topColor = dayColorList[currentAtmosphere]["top"]
	var horizonColor = dayColorList[currentAtmosphere]["horizon"]
	
	var tween = create_tween()
	
	tween.tween_property(world_environment, "environment:sky:sky_material:sky_top_color", topColor, durationMultiplier)
	tween.parallel()
	tween.tween_property(world_environment, "environment:sky:sky_material:sky_horizon_color", horizonColor, durationMultiplier)
	tween.parallel()
	tween.tween_property(world_environment, "environment:sky:sky_material:ground_bottom_color", topColor, durationMultiplier)
	tween.parallel()
	tween.tween_property(world_environment, "environment:sky:sky_material:ground_horizon_color", horizonColor, durationMultiplier)

func _pass_time():
	currentAtmosphere = ((currentAtmosphere + 1) % 4) as atmosphere
	_set_sun(timesList[currentAtmosphere]["time"])
	_day_change_animation()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_pass_time()
