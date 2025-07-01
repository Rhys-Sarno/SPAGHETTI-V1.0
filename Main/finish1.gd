extends Node2D

signal end
var entered = false
@onready var animation_player = $AnimationPlayer 

func _on_area_2d_area_entered(area: Area2D) -> void:
	animation_player.play("pickup")
	emit_signal("end	")
	
func _on_end(delta):
	get_tree().change_scene_to_file("res://Main/levels/level_2.tscn")
