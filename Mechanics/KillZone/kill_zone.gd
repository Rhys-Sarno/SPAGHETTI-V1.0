extends Area2D

@onready var is_alive = true
@onready var timer = $Timer


func killZoneTouched(area):
	print("Dead")
	Engine.time_scale = 0.5
	timer.start()
	$Hurt.play()
	is_alive = false

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
	
func player_death():
	var start_position = position 
	var up_position = start_position + Vector2(0, -100)
	var down_position = start_position + Vector2(0, 600)
	


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.die()
