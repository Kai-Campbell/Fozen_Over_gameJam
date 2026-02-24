extends Node

@onready var plane: Interactable = $Plane
@onready var collision_shape_3d: CollisionShape3D = $Plane/CollisionShape3D


func _ready() -> void:
	if Global.decision_made == true:
		pass
		
func _process(_delta: float) -> void:
	if Global.kill_pilot == true:
		plane.set_collision_layer_value(2, true)
		plane.set_collision_mask_value(2, true)
		
	if Global.decision_made == true:
		get_tree().change_scene_to_file("res://Scenes/world.tscn") # change this to a cutscene

	if Global.leave_pilot_to_die == true:
		get_tree().change_scene_to_file("res://Scenes/world.tscn")
