class_name Game
extends Node2D

@onready var map: Node2D = $Map
@onready var camera: Camera2D = $Camera

const VINX_HOME = preload("res://src/scenes/maps/vinx home.tscn")
const TITLESCREEN = preload("res://src/scenes/titlescreen.tscn")

@export var testing = true ## grene fortniet domungus

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.change_camera(false)
	if !testing:
		map.queue_free()
		var title = TITLESCREEN.instantiate()
		add_child(title)
	Global.change_camera(true)

func NEW_GAME():
	Global.locked = true
	var intro_map = VINX_HOME.instantiate()
	$player.global_position = Vector2(2448, 180)
	camera.mode = "player"
	camera.limit_bottom = 240
	camera.limit_right = 2560
	camera.limit_top = 0
	camera.limit_left = 0
	add_child(intro_map)
	
