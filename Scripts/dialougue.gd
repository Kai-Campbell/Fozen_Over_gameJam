extends CanvasLayer

@onready var dialougue_box: Control = $"Dialougue Box"
@onready var dialogue_text: Label = $"Dialougue Box/DialogueText"

var dialogue_box : Array[String] = []
var current_line_index : int = 0
var is_dialogue_active : bool = false

func _ready() -> void:
	dialougue_box.visible = false
