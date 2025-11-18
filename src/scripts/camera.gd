extends Camera2D

@export var player : Player
@export var smooth : bool = true
@onready var size : Vector2i = get_viewport_rect().size
@export_enum("zelda","player","fixed") var mode : String = "zelda"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.offscreen.connect(update_position)
	update_position()

func _process(_delta: float) -> void:
	if mode == "player": update_position()

#TODO: make player mode focus on the player! how to do bounds?!
func update_position(pos = Vector2(0,0)):
	match mode:
		"zelda":
			anchor_mode = ANCHOR_MODE_FIXED_TOP_LEFT
			position_smoothing_enabled = smooth
			var current_cell : Vector2i = Vector2i(player.global_position) / size
			global_position = current_cell * size
		"player":
			anchor_mode = ANCHOR_MODE_DRAG_CENTER
			position_smoothing_enabled = smooth
			global_position = player.position
		"fixed":
			position_smoothing_enabled = smooth
			global_position = pos
