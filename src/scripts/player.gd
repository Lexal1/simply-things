extends CharacterBody2D
class_name Player

const speed = 5252

@onready var npc_cast: RayCast2D = $NPCCast

@export var vg_mode : bool = false

signal offscreen

var current_dir = 3

func _ready(): print("starting")

func _physics_process(delta): _player_movement(delta)

func _player_movement(delta):
	if Global.locked == false:
		#TODO: make less suck bad
		if Input.is_action_pressed("right"):
			npc_cast.target_position = Vector2(15,0)
			current_dir = 0
			_play_anim(1)
			velocity.x = speed * delta
			velocity.y = 0
		elif Input.is_action_pressed("left"):
			npc_cast.target_position = Vector2(-15,0)
			current_dir = 2
			_play_anim(1)
			velocity.x = -speed * delta
			velocity.y = 0
		elif Input.is_action_pressed("down"):
			npc_cast.target_position = Vector2(0,15)
			current_dir = 3
			_play_anim(1)
			velocity.x = 0
			velocity.y = speed * delta
		elif Input.is_action_pressed("up"):
			npc_cast.target_position = Vector2(0,-15)
			current_dir = 1
			_play_anim(1)
			velocity.x = 0
			velocity.y = -speed * delta
		else:
			_play_anim(0)
			velocity.x = 0
			velocity.y = 0
		
		if Input.is_action_just_pressed("1"):
			if npc_cast.is_colliding():
				if npc_cast.get_collider() is NPC:
					Global.locked = true
					npc_cast.get_collider().talk()
					await DialogueManager.dialogue_ended
					await get_tree().create_timer(0.2).timeout
					Global.locked = false
				elif npc_cast.get_collider() is Door:
					Global.locked = true
					npc_cast.get_collider()._on_body_entered(self)
					await DialogueManager.dialogue_ended
					await get_tree().create_timer(0.2).timeout
					Global.locked = false
		
		move_and_slide()

func _play_anim(movement):
	var dir = current_dir
	var anim : AnimatedSprite2D
	if vg_mode: anim = $VG
	else: anim = $Sprite
	#TODO: make not suck but real
	if dir == 0:
		anim.flip_h = false
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == 1:
		if movement == 1:
			anim.play("back_walk")
		elif movement == 0:
			anim.play("back_idle")
	if dir == 2:
		anim.flip_h = true
		if movement == 1:
			anim.play("side_walk")
		elif movement == 0:
			anim.play("side_idle")
	if dir == 3:
		if movement == 1:
			anim.play("front_walk")
		elif movement == 0:
			anim.play("front_idle")

func _on_on_screen_screen_exited() -> void:
	offscreen.emit()
