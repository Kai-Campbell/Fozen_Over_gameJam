extends CollisionObject3D
class_name Interactable

signal interacted(body)
@export var prompt_text = "Pick Up"

@onready var stick: Sprite3D = %Stick
@onready var light: Sprite3D = %Light
@onready var mind_reader: Sprite3D = %MindReader


@export var dialogue :DialogueResource
@export var dialogue_start : String = "start"

func interact(body):
	interacted.emit(body)
	print("interacted")
	
		
func talk() -> void:
	DialogueManager.show_dialogue_balloon(dialogue, dialogue_start)
