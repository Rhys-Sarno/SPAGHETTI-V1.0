extends Node

var musicProgress = 0.0 #By being at 0, it will always start at the beginning when you launch the game   



var current_collectables : int = 0
func _on_collectable_collected():
	current_collectables += 1
	print(current_collectables)
