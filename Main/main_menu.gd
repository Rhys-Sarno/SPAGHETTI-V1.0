extends Control

@onready var SFX_BUS = AudioServer.get_bus_index("SFX")
@onready var MUSIC_BUS = AudioServer.get_bus_index("Music")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Play button sends you to level 1
func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Main/levels/level_1.tscn")

# Closes game
func _on_exit_pressed() -> void:
	get_tree().quit()

# Toggles Music
func _on_music_pressed() -> void:
		AudioServer.set_bus_mute(MUSIC_BUS, not AudioServer.is_bus_mute(MUSIC_BUS))

	
# Toggles SFX
func _on_sfx_pressed() -> void:
	AudioServer.set_bus_mute(SFX_BUS, not AudioServer.is_bus_mute(SFX_BUS))
