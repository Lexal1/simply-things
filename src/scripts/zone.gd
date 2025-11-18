extends Area2D

const DARKNESS = preload("res://src/scenes/darkness.tscn")

@export var music : AudioStreamOggVorbis
@export var fade : bool = false
@export var dark : bool = false
@export var enabled : bool = true

var i = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !enabled: $Collision.disabled = true

func toggle_enabled():
	if !enabled: $Collision.disabled = false
	else: $Collision.disabled = true

#TODO: finish rewrite
#bug involving entering and exiting zones fast! help
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		if Global.audio.stream != music: Global.audio.stream = music
		i = true

		Global.audio.start()

		if dark:
			var darken = DARKNESS.instantiate()
			body.add_child(darken)
			darken.darken(true)
	

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		i = false

		Global.audio.fade()

		if dark:
			body.get_child(-1).darken(false)
			await body.get_child(-1).Fanimation.animation_finished
			if i and body.get_child(-1).Fanimation.is_playing(): body.get_child(-1).Fanimation.play_backwards()
			elif !i and !body.get_child(-1).Fanimation.is_playing(): body.get_child(-1).queue_free()
	
