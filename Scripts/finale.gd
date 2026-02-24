extends Node

@onready var plane: Interactable = $Plane
@onready var collision_shape_3d: CollisionShape3D = $Plane/CollisionShape3D
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"


func _ready() -> void:
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 2.0)
	
		
func _process(_delta: float) -> void:
	if Global.kill_pilot == true: # enables the exit plane collision
		plane.set_collision_layer_value(2, true)
		plane.set_collision_mask_value(2, true)
		
	if Global.decision_made_10_sec == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/10Sec.tscn") # change this to a cutscene

	if Global.decision_made_20_min == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/20_minutes.tscn")

	if Global.leave_pilot_to_die == true: # actually ends the level
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/kill_pilot_end.tscn")
