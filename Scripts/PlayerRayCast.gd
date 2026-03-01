extends RayCast3D
@onready var ray_cast_3d: RayCast3D = $"."
@onready var prompt: Label = $"../../UI/Prompt"
@onready var example_balloon: CanvasLayer = $"../../../../ExampleBalloon"


func _ready() -> void:
	example_balloon.visibility_changed.connect(_stop_raycast)
	example_balloon.visibility_changed.connect(_start_raycast)

func _physics_process(_delta: float) -> void:
	prompt.text = ""
	
	if is_colliding():
		var collider = get_collider()
		
		if collider is Interactable:
			prompt.text = collider.prompt_text
	
		if Input.is_action_just_pressed("interact"):
			if collider.is_in_group("Talk"):
				collider.talk()
			if collider.is_in_group("Interactable"):
				if collider.is_in_group("Light"):
					collider.get_parent().visible = false
					Global.has_light = true
					collider.queue_free()
				if collider.is_in_group("Flight Stick"):
					collider.get_parent().visible = false
					Global.has_flight_stick = true
					collider.queue_free()
				if collider.is_in_group("Alien Device"):
					collider.get_parent().visible = false
					Global.has_alien_device = true
					collider.queue_free()
					
func _stop_raycast():
	enabled = false
	visible = false
	print("hello")

func _start_raycast():
	enabled = true
	visible = true
