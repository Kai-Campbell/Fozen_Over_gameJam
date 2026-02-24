extends Node3D
@onready var kid: AnimatedSprite3D = $Items/Kid
@onready var kid_no_hat: Sprite3D = $Items/KidNoHat

func _process(_delta: float) -> void:
	if Global.has_prop == true:
		kid.visible = false
		kid_no_hat.visible = true
	
	if Global.leave == true:
		get_tree().change_scene_to_file("res://Scenes/Finale.tscn")
	
