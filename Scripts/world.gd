extends Node3D
@onready var kid: AnimatedSprite3D = $Items/Kid
@onready var kid_no_hat: Sprite3D = $Items/KidNoHat
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"
@onready var start_door: CSGBox3D = $StartDoor
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var main_guy: Node3D = $MainGuy
@onready var bunk_pos: Node3D = $"Bunker Stuff/Bunk POS"
@onready var leave_pos: Node3D = $"Bunker Stuff/Leave POS"

func _ready() -> void:
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 3.0)
	#this signal emits after talking to the mayor so the door opens
	Global.start_game.connect(move_door)

func _process(_delta: float) -> void:
	if Global.has_prop == true:  # probably unnecssary, remove after game jam
		kid.visible = false
		kid_no_hat.visible = true
	
	#starts the level transition
	if Global.leave == true:
		await fade_to_black_metallica.fade(1.0, 2.0).finished
		get_tree().change_scene_to_file("res://Scenes/Finale.tscn")

func move_door():
	animation_player.play("move_door")
	await animation_player.animation_finished
	start_door.queue_free()

func _on_example_balloon_visibility_changed() -> void:
	visibility_changed.emit()

func _on_secret_door_interacted(_body: Variant) -> void:
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 2.0)
	main_guy.get_child(0).global_position = bunk_pos.global_position
	main_guy.get_child(0).change_music(main_guy.get_child(0).bunk_music)

func _on_leave_interacted(_body: Variant) -> void:
	fade_to_black_metallica.fade(1.0, 0.0)
	fade_to_black_metallica.fade(0.0, 1.0)
	main_guy.get_child(0).global_position = leave_pos.global_position
	main_guy.get_child(0).change_music(main_guy.get_child(0).reg_music)
	animation_player.play("Block Entrance")
