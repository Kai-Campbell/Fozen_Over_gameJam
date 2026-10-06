extends CharacterBody3D

@onready var camera_3d: Camera3D = $Head/Camera3D
@onready var head: Node3D = $Head
@onready var label: Label = $UI/Label
@onready var background_mursic: AudioStreamPlayer = $UI/BackgroundMursic
@onready var walkingsounds: AudioStreamPlayer = $UI/walkingsounds
@onready var foot_cast: RayCast3D = $Feet/FootCast
@onready var walktimer: Timer = $UI/walktimer


var default_walk_sound = load("res://Assets/Audio/SFX/JDSherbert - Footstep Foley SFX Pack - Footstep (Snow - 1).wav")
var walkway_sound = load("res://Assets/Audio/SFX/walkway_sound.mp3")
var carpet_sound = load("res://Assets/Audio/SFX/carpet_sound.mp3")
var stone_sound = load("res://Assets/Audio/SFX/stone_sound.mp3")
var metal_sound = load("res://Assets/Audio/SFX/metal_sound.mp3")
var wood_sound = load("res://Assets/Audio/SFX/wood_sound.mp3")
var dirt_sound = load("res://Assets/Audio/SFX/dirt_sound_1.mp3")
var current_sound

var reg_music = load("res://Assets/Audio/Music/Frozen OVer but better.mp3")
var bunk_music = load("res://Assets/Audio/Music/BunkTheme.mp3")
var finale_music = load("res://Assets/Audio/Music/Finale.mp3")

const SPEED = 9.0
const RUN = 20.0
const JUMP_VELOCITY = 9.0
const GRAVITY_MULTIPLIER = 1.8
const WALK_TIMER_RUN = 0.3
const WALK_TIMER_WALK = 0.6

var look_direction: Vector2
var camera_sens = 0.005
var current_speed = SPEED
var can_move : bool = true

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Global.text_start.connect(stop)
	Global.text_end.connect(move_again)
	Global.item_aquired.connect(display_item)
	background_mursic.play()

func _input(event: InputEvent) -> void:
	if can_move:
		if event is InputEventMouseMotion:
			rotate_y(-event.relative.x * camera_sens)
			head.rotate_x(-event.relative.y * camera_sens)
			head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(70))

#this whole thing just doesnt work, so until then its going in a comment
func _process(_delta: float) -> void:
	if foot_cast.is_colliding() and is_on_floor():
		var ground = foot_cast.get_collider().name
		
		# I could use a match case here, but match cases dont work with dynamic variables
		# it has to be a constant value like a string, so I'm using an elif statement instead.
		
		if ground == Global.current_world_floors[0]:
			#snow
			change_walking_sound(default_walk_sound)
		elif ground == Global.current_world_floors[1]:
			#walkway
			change_walking_sound(walkway_sound)
		elif ground == Global.current_world_floors[2]:
			#metal
			change_walking_sound(metal_sound)
		elif ground == Global.current_world_floors[3]:
			#carpet
			change_walking_sound(carpet_sound)
		elif ground == Global.current_world_floors[4]:
			#stone
			change_walking_sound(stone_sound)
		elif ground == Global.current_world_floors[7]:
			#wood
			change_walking_sound(wood_sound)
		elif ground == Global.current_world_floors[6]:
			#dirt
			change_walking_sound(dirt_sound)
		else:
			change_walking_sound(default_walk_sound)


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += (get_gravity() * delta) * GRAVITY_MULTIPLIER

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		velocity.y = JUMP_VELOCITY
		if walkingsounds.playing:
			walkingsounds.stop()

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	if Input.is_action_pressed("run"):
		current_speed = RUN
		if !walktimer.timeout || walktimer.wait_time == WALK_TIMER_RUN:
			pass
		else:
			walktimer.wait_time = WALK_TIMER_RUN
	else:
		current_speed = SPEED
		if !walktimer.timeout || walktimer.wait_time == WALK_TIMER_WALK:
			pass
		else:
			walktimer.wait_time = WALK_TIMER_WALK
	
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if can_move:
		if direction:
			velocity.x = direction.x * current_speed
			velocity.z = direction.z * current_speed
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)
			if walkingsounds.playing:
				walkingsounds.stop()
	else:
		velocity.x = 0
		velocity.z = 0
	
	# im going to be honest I hate that this works, but it does. Next time think ahead when doing the walking sounds
	if velocity.length() != 0 and is_on_floor():
		if walktimer.time_left <= 0.0:
			walkingsounds.play()
			walktimer.start()
	
	move_and_slide()

func change_music(song):
	background_mursic.stream = song
	background_mursic.play()


func change_walking_sound(stream):
	if current_sound == stream:
		return
	walkingsounds.stop()
	walkingsounds.stream = stream
	current_sound = stream


'these functions control whether the player can move when text starts'
func stop():
	can_move = false

func move_again():
	can_move = true

func display_item(item : String):
	label.text = str(item, " picked up")
	await get_tree().create_timer(3).timeout
	label.text = ""
