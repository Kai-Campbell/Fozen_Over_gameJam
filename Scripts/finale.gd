extends Node

@onready var plane: Interactable = $Plane
@onready var collision_shape_3d: CollisionShape3D = $Plane/CollisionShape3D
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"
@onready var pilot: Sprite3D = $pilot
@onready var pilot_with_gun: Sprite3D = $PilotWithGun
@onready var main_guy: Node3D = $MainGuy
@onready var shotpilotdeadlol: Interactable = $shotpilotdeadlol


func _ready() -> void:
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 2.0)
	Global.pilot_with_gun.connect(change_pilot_sprite)
	Global.choose_time.connect(disable_talk)
	main_guy.get_child(0).change_music(main_guy.get_child(0).finale_music)

func disable_talk():
	$pilot/StaticBody3D.queue_free()

func change_pilot_sprite():
	pilot.visible = false
	$"gun cock".play()
	pilot_with_gun.visible = true

func _process(_delta: float) -> void:
	if Global.kill_pilot == true: # enables the exit plane collision
		plane.set_collision_layer_value(2, true)
		plane.set_collision_mask_value(2, true)
	
	if Global.shoot_pilot == true:
		shotpilotdeadlol.set_collision_layer_value(2, true)
		shotpilotdeadlol.set_collision_mask_value(2, true)
	
	if Global.leave_shooted_pilot == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		#get_tree().change_scene_to_file("res://Scenes/10Sec.tscn")
	
	if Global.decision_made_10_sec == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/10Sec.tscn") # change this to a cutscene

	if Global.decision_made_20_min == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/20_minutes.tscn")

	if Global.leave_pilot_to_die == true: # actually ends the level
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/kill_pilot_end.tscn")
