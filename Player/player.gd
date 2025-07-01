class_name Player
extends CharacterBody2D

@export var state_machine : StateMachine

@export_category("Moving")
@export var move_speed : float = 400.0
@export var max_speed_x : float = 1750.0
@export var max_speed_y : float = 1500.0
@export var jump_height : float = 120.0
@export var jump_time_to_peak : float = 0.4
@export var jump_time_to_descent : float = 0.4

@export_category("Effects")
@export var blast : PackedScene

@onready var jump_velocity : float = -((2.0 * jump_height) / jump_time_to_peak)
@onready var jump_gravity : float = -((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak))
@onready var fall_gravity : float = -((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent))

@onready var animated_sprite = $AnimatedSprite2D

# Handles death of player so they can't move on death
var can_control : bool = true

# Dash components (originally was going to be a spin but changed the idea)
const spin_speed = 900.0 
var spinning = false 
var can_dash = true

# Double jump components
var jump_count = 0
var max_jump = 2

func _ready():
	state_machine.enter()


func _unhandled_input(_event):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	
	state_machine.playerInput(_event)


func _physics_process(delta):
	if not can_control: return
	state_machine.playerPhysicsProcess(delta)
	move_and_slide()
	
	# Flip the character when moving left / right
	var direction = Input.get_axis("move_left", "move_right")
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Spin component
	if Input.is_action_just_pressed("spin") and can_dash:
		spinning = true
		can_dash = false
		$spin_timer.start()
		$Dash.play()
	
	if direction:
		if spinning:
			velocity.x = direction * spin_speed

	# Double jump component
	if Input.is_action_just_pressed("ui_accept") and jump_count < max_jump: 
		velocity.y = jump_velocity
		jump_count += 1
		$Jump.play()
	
	if is_on_floor():
		jump_count = 0 # Reset double jump
		$spin_again_timer.start() # Restart dash timer
		# Play the correct animation
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
		
# Timer on spin to make it stop
func _on_spin_timer_timeout() -> void:
	spinning = false 
	
# Timer for when you can spin again
func _on_spin_again_timer_timeout() -> void:
	can_dash = true
	
func dash(speed, direction, _charge):

	var dash_vector : Vector2 = direction * speed
	
	if direction.dot(velocity) < 0:
		velocity.x *= 0.75
	
	# If dashing in opposite y direction and falling
	if direction.y < 0 and velocity.y > 0:
		velocity.y = 0
	
	velocity += dash_vector
	velocity.x = clampf(velocity.x, -max_speed_x, max_speed_x)
	velocity.y = clampf(velocity.y, -max_speed_y, max_speed_y)
	
	emitBlastParticle(direction)


func emitBlastParticle(direction : Vector2) -> void:
	var new_blast : GPUParticles2D = blast.instantiate()
	get_parent().add_child(new_blast)
	new_blast.global_position = global_position
	new_blast.look_at(global_position - direction)
	new_blast.emitting = true
	
func _on_dash_component_dashed(speed: float, direction: Vector2, charge: float) -> void:
	pass # Replace with function body.

func die() -> void:
	print("die")
	animated_sprite.play("death")
	can_control = false
