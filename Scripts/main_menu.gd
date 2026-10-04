extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var options: CanvasLayer = $Options

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")

func _on_button_2_pressed() -> void:
	v_box_container.visible = false
	options.visible = true

func _on_return_pressed() -> void:
	v_box_container.visible = true
	options.visible = false
