extends Node

@export var value : int

func _ready() -> void:
	if Global.EXIT != value:
		get_parent().visible = false
		if get_parent() == Door: print(get_parent().get_child(0))
