extends CanvasLayer

var paused = false
@onready var pause_menu_layer: CanvasLayer = $"."

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
		else:
			pause_menu()


func _on_resume_pressed() -> void:
	resume()
