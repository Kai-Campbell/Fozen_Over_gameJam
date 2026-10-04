extends CanvasLayer

var paused = false
var options_up = false
var are_you_sure_up = false

@onready var are_you_sure_: CanvasLayer = $"are you sure?"
@onready var pause_menu_layer: CanvasLayer = $"."
@onready var box: Control = $Control/Box
@onready var options: CanvasLayer = $Control/Options

func pause_menu():
	get_tree().paused = true
	pause_menu_layer.visible = true
	paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func resume():
	get_tree().paused = false
	pause_menu_layer.visible = false
	paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("escape"):
		if paused:
			resume()
			if options_up:
				_on_button_pressed()
			if are_you_sure_up:
				_on_return_pressed()
		else:
			pause_menu()


func _on_resume_pressed() -> void:
	resume()


func _on_settings_pressed() -> void:
	options.visible = true
	box.visible = false
	options_up = true


func _on_button_pressed() -> void:
	options.visible = false
	box.visible = true
	options_up = false


func _on_back_to_title_pressed() -> void:
	box.visible = false
	are_you_sure_.visible = true
	are_you_sure_up = true


func _on_return_pressed() -> void:
	box.visible = true
	are_you_sure_.visible = false
	are_you_sure_up = false


func _on_yes_pressed() -> void:
	resume()
	are_you_sure_up = false
	are_you_sure_.visible = false
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
