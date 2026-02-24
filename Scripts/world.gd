extends Node3D
@onready var kid: AnimatedSprite3D = $Items/Kid
@onready var kid_no_hat: Sprite3D = $Items/KidNoHat
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"

func _process(_delta: float) -> void:
	if Global.has_prop == true:  # probably unnecssary, remove after game jam
		kid.visible = false
		kid_no_hat.visible = true
	
	if Global.leave == true:
		await fade_to_black_metallica.fade(1.0, 2.0).finished
		get_tree().change_scene_to_file("res://Scenes/Finale.tscn")
	
