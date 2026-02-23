extends RayCast3D
@onready var ray_cast_3d: RayCast3D = $"."
@onready var prompt: Label = $"../../UI/Prompt"

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
				collider.interact(owner)
