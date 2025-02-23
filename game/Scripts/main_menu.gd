extends Control

func _ready() -> void:
	Menu.block = true

func _on_button_button_down() -> void:
	Menu.block = false
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
