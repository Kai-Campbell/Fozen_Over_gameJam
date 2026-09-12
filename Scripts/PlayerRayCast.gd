extends RayCast3D
@onready var ray_cast_3d: RayCast3D = $"."
@onready var prompt: Label = $"../../UI/Prompt"


func _ready() -> void:
	Global.text_start.connect(_stop_raycast)
	Global.text_end.connect(_start_raycast)

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
					Global.item_aquired.emit("Light")
					collider.queue_free()
				if collider.is_in_group("Flight Stick"):
					collider.get_parent().visible = false
					Global.has_flight_stick = true
					Global.item_aquired.emit("Flight Stick")
					collider.queue_free()
				if collider.is_in_group("Alien Device"):
					collider.get_parent().visible = false
					Global.has_alien_device = true
					Global.item_aquired.emit("Strange Device")
					collider.queue_free()
				if collider.is_in_group("Gun"):
					collider.get_parent().visible = false
					Global.has_gun = true
					Global.item_aquired.emit("Missing Gun")
					collider.queue_free()
			if collider.is_in_group("Stuff"):
				collider.interact(self)
func _stop_raycast():
	enabled = false
	visible = false

func _start_raycast():
	enabled = true
	visible = true
