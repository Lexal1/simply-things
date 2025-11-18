class_name Door
extends Area2D

@export var newmap : PackedScene
@export var destination : Vector2
@export var locked : bool = false
@export var locked_dialogue : String = "locked"
@export var change_cam : bool = true

const GENERIC = preload("res://src/scripts/dialogue/generic.dialogue")

@onready var collision: CollisionPolygon2D = $Collision
@onready var dest: Marker2D = $Destination

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		Global.locked = true
		if !locked:
			if newmap != null:
				var new = newmap.instantiate()
				Global.call_deferred("add_child", new)
				body.global_position = destination
				Global.get_node("Map").queue_free()
			else:
				if change_cam:
					Global.change_camera(false)
					Global.screen_animate("cut to black", true)
				body.global_position = dest.global_position
				await get_tree().create_timer(0.5).timeout
				if change_cam:
					Global.change_camera(true)
					Global.screen_animate("cut from black", false)
		else: 
			DialogueManager.show_dialogue_balloon(GENERIC, locked_dialogue)
			await DialogueManager.dialogue_ended
		Global.locked = false
