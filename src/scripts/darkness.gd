extends AnimatedSprite2D

@onready var Fanimation: AnimationPlayer = $Animation

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func darken(b : bool = false):
	if b:
		Fanimation.play("fade_in")
	else: Fanimation.play("fade_out")
