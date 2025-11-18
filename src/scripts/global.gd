extends Node

@onready var screen: AnimationPlayer = $Black/Transition

@onready var audio: AudioStreamPlayer = $Audio

var EXIT = 0
var locked : bool = false

var inventory : Array = []

func _ready() -> void:
	screen.play("cut from black")
	EXIT = randi_range(0,99)
	print(EXIT)
	

func add_item(item : String):
	inventory.append(item)
	inventory.sort()
	

func remove_item(item : String):
	var i = inventory.find(item)
	if i != -1:
		inventory.remove_at(i)
		return true
	else:
		print("you don't have that")
		return false
	

func change_camera(smooth : bool = true, mode : String = "zelda"):
	var smoothie = get_node("/root/Game/Camera")
	if smoothie == null: get_node("/root/VGMini/Camera")
	smoothie.mode = mode
	smoothie.smooth = smooth
	

func screen_animate(ani : String, wait : bool = false, mute : bool = false):
	if mute: audio.stop()
	screen.play(ani)
	if wait: await screen.animation_finished
	else: pass
	
