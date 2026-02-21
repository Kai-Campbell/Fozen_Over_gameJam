extends CharacterBody3D

@onready var camera_3d: Camera3D = $Head/Camera3D
@onready var head: Node3D = $Head

const SPEED = 9.0
const RUN = 20.0
const JUMP_VELOCITY = 4.5

var look_direction: Vector2
var camera_sens = 0.005
var is_sprinting = false
var current_speed = SPEED

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * camera_sens)
		head.rotate_x(-event.relative.y * camera_sens)
		head.rotation.x = clamp(head.rotation.x, deg_to_rad(-60), deg_to_rad(70))


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	is_sprinting = Input.is_action_pressed("run")
	current_speed = RUN if is_sprinting else SPEED
	
	var input_dir := Input.get_vector("left", "right", "up", "down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	

	move_and_slide()
