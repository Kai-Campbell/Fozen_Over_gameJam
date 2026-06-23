extends Node3D


func _on_static_body_3d_interacted(body: Variant) -> void:
	get_tree().change_scene_to_file("res://Scenes/world.tscn")
