extends Node2D

const speed = 400.0
const spin_speed = 900.0 
var spin = false 
var velocity = 0

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("spin"):
		pass
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		if spin:
			velocity.x = direction * spin_speed
		else:
			velocity.x = direction * speed
