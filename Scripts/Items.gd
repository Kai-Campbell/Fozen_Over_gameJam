extends Node
@onready var mind_reader: Sprite3D = %MindReader
@onready var stick: Sprite3D = %Stick
@onready var light: Sprite3D = %Light

func _ready() -> void:
	mind_reader.interacted.connect(_on_item_grabbed())
	light.interacted.connect(_on_item_grabbed())
	
func _on_item_grabbed():
	mind_reader.visible = false
	light.visible = false
