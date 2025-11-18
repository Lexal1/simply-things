extends VisibleOnScreenEnabler2D

@export var dia : String = "start"


@onready var sfx: AudioStreamPlayer = $DialogueLabel/SFX
@onready var sfxdone: AudioStreamPlayer = $DialogueLabel/SFXDONE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var resource = load("res://src/scripts/dialogue/game.dialogue")
	$DialogueLabel.dialogue_line = await resource.get_next_dialogue_line(dia)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_dialogue_label_spoke(letter: String, letter_index: int, speed: float) -> void:
	if letter != "!" or "." or "," or "?" or " ":
		if !$DialogueLabel/SFX.playing: $DialogueLabel/SFX.play()
	if $DialogueLabel.get_total_character_count()-1 == letter_index: $DialogueLabel/SFXDONE.play()

func _on_screen_entered() -> void:
	$DialogueLabel.type_out()
