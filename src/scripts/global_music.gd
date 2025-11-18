extends AudioStreamPlayer

@onready var animation: AnimationPlayer = $Animation

@export var volume : float = 1.1

var i = false

func _ready() -> void:
	autoplay = false

func _process(delta: float) -> void:
	volume_db = linear_to_db(volume)

#TODO: finish rewrite!
#BUG: randomly stops if you walk back and forth too much
#BUG: does not work with doors!
func start(fade_in : bool = false):
	i = true
	if !playing:
		print("start")
		animation.stop()
		play()
		if fade_in: animation.play_backwards("fade")
	elif animation.is_playing() and i: #we're supposed to be fading in!
			print("im going to scream")
			animation.play_backwards()
	else: pass

func fade(out : bool = true):
	i = false
	if out:
		print("supposed to be fading out")
		if !animation.is_playing():
			animation.play("fade")
			await animation.animation_finished
			if !i:
				await get_tree().create_timer(2)
				if !i: stop()
	volume = 1
		
