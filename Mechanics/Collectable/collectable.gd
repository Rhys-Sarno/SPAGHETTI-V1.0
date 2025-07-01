class_name Collectable
extends Node2D

signal collected
const FILE_BEGIN = "res://Main/levels/level_"
@onready var animation_player = $AnimationPlayer 
@onready var timer = $Timer
@onready var game_manager = %GameManager

func _on_area_2d_area_entered(area):
	if area.owner is Player:
		timer.start()
		print("Collected")
		emit_signal("collected")
		animation_player.play("pickup")
		Engine.time_scale = 0.25
		
func _on_collected():
	pass

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	var current_scene_file = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	var next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	get_tree().change_scene_to_file(next_level_path)
