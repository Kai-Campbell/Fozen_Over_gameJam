extends Control

func _ready() -> void:
	$AudioStreamPlayer2D.play()

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
