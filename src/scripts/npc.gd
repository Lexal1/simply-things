class_name NPC
extends Area2D

@export var dialogue : DialogueResource = null
@export var pointer : String = "start"
@export var has_idle : bool = false
@export var has_secondary : bool = false ## Has secondary dialogue. will automatically change the pointer to *_2.
@export var talked_to : NPC              ## Has reactionary dialogue. will automatically change the pointer to *_3.

var talked : bool = false

@onready var sprite: AnimatedSprite2D = $Sprite

func _ready() -> void:
	if has_idle: sprite.play("idle")

func talk():
	var greenland = ""
	if talked_to != null and talked_to.talked: greenland = "_3"
	elif has_secondary and talked: greenland = "_2"
	var prev = pointer
	pointer = pointer+greenland
	print(pointer)
	print(dialogue)
	
	if sprite.sprite_frames != null: sprite.play("default")
	
	DialogueManager.show_dialogue_balloon(dialogue)
	await DialogueManager.dialogue_ended
	
	sprite.play("idle") if has_idle else sprite.stop()
	
	if !talked: talked = true
	
	pointer = prev
