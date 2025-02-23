extends CanvasLayer

var block = true
var rec = 0
var last_try = 0
var score = 0
var words = 0
var record = 0
var bonus = 0
var bonus_up = 1

func showw() -> void:
	visible = true
	print("lol")
	$info.text = "Всего угаданно слов: {0}\nРекорд: {1}\nОпыт: {2}".format([words, record, score])

func hidee() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_ESCAPE:
			if !block and !visible: showw()

func _on_continue_button_down() -> void:
	hidee()

func _on_quit_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
