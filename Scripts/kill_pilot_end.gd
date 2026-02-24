extends CanvasLayer
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"
@onready var end: Label = $End
@onready var h_box_container: HBoxContainer = $HBoxContainer

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 3.0)



func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_button_2_pressed() -> void:
	get_tree().quit()


func _on_timer_timeout() -> void:
	end.visible = true
	h_box_container.visible = true
