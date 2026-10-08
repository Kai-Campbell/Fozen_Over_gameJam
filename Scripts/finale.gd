extends Node

@onready var plane: Interactable = $Plane
@onready var collision_shape_3d: CollisionShape3D = $Plane/CollisionShape3D
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"
@onready var pilot: Sprite3D = $pilot
@onready var pilot_with_gun: Sprite3D = $PilotWithGun
@onready var main_guy: Node3D = $MainGuy
@onready var shotpilotdeadlol: Interactable = $shotpilotdeadlol
@onready var world: FuncGodotMap = $World


func _ready() -> void:
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 2.0)
	Global.pilot_with_gun.connect(change_pilot_sprite)
	Global.choose_time.connect(disable_talk)
	main_guy.change_music(main_guy.finale_music)
	Global.play_gun_sound.connect(play_gun_sound)
	
		# Gets all of the func godots entity's names and puts them in the current worlds floors
	if Global.current_world_floors.size() > 0:
		Global.current_world_floors.clear()
	for i in world.get_children():
		Global.current_world_floors.append(i.name)

func disable_talk():
	$pilot/StaticBody3D.queue_free()

func change_pilot_sprite():
	pilot.visible = false
	$"gun cock".play()
	pilot_with_gun.visible = true

func play_gun_sound():
	$"gun cock".play()

func _process(_delta: float) -> void:
	if Global.kill_pilot == true: # enables the exit plane collision
		plane.set_collision_layer_value(2, true)
		plane.set_collision_mask_value(2, true)
	
	if Global.shoot_pilot == true:
		shotpilotdeadlol.set_collision_layer_value(2, true)
		shotpilotdeadlol.set_collision_mask_value(2, true)
	
	if Global.shooted_pilot == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/shoot_pilot.tscn")
	
	if Global.strike_the_deal == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/leavewith_pilot.tscn")
	
	if Global.decision_made_10_sec == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/10Sec.tscn")

	if Global.decision_made_20_min == true:
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/20_minutes.tscn")

	if Global.leave_pilot_to_die == true: # actually ends the level
		await fade_to_black_metallica.fade(1.0, 1.5).finished
		get_tree().change_scene_to_file("res://Scenes/kill_pilot_end.tscn")
