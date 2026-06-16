extends Node3D
@onready var kid: AnimatedSprite3D = $Items/Kid
@onready var kid_no_hat: Sprite3D = $Items/KidNoHat
@onready var fade_to_black_metallica: CanvasLayer = $"Fade To Black Metallica"
@onready var start_door: CSGBox3D = $StartDoor
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
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
