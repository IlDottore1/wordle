extends Control

@export var green : Color
@export var yellow : Color
@export var grey : Color

var word = "HOUSE"
var keys : Dictionary = {}
var cells : Array = [{}, {}, {}, {}, {}, {}]
var lines = [0,0,0,0,0,0]
var let = ["Q",'W','E','R','T','Y','U','I','O','P','A','S','D','F','G','H','J','K','L','Z','X','C','V','B','N','M']

func _ready() -> void:
	for i in $KeyBoard/Grid/Line1.get_children():
		keys[i] = "no"
	for i in $KeyBoard/Grid/Line2.get_children():
		keys[i] = "no"
	for i in $KeyBoard/Grid/MarginContainer/Line3.get_children():
		keys[i] = "no"
	
	var x = $Cells.get_children()
	for i in range(len(x)):
		cells[int(i/5)][x[i]] = 0
	
	randomize()
	word = Words.words[randi() % 663]
	

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var e = OS.get_keycode_string(event.keycode).to_upper()
		if e in let:
			key_click(e)
		elif e == "BACKSPACE":
			delete()
		elif e == "ENTER":
			enter()
	

func key_click(s : String) -> void:
	var x = cells[lines.find(0)].find_key(0)
	if x: # если еще есть свободные слоты
		x.get_node("Label").text = s
		cells[lines.find(0)][x] = 1
	else: # если свободных слотов не осталось
		cells[lines.find(0)].keys()[-1].get_node("Label").text = s

func delete() -> void:
	var x = cells[lines.find(0)]
	var t = x.find_key(0)
	if t:
		t = x.keys()[x.keys().find(t)-1] # последний непустой слот
		t.get_node("Label").text = ""
		cells[lines.find(0)][t] = 0
	else:
		t = x.keys()[-1]
		t.get_node("Label").text = ""
		cells[lines.find(0)][t] = 0
		

func enter() -> void:
	var x = cells[lines.find(0)]
	var t = x.find_key(0)
	if !t:
		var c = 0
		lines[lines.find(0)] = 1
		for i in range(len(x.keys())):
			var s = x.keys()[i].get_node("Label").text
			if s in word:
				if word.find(s) == i:
					var k
					for j in keys:
						if j.name == "Button"+s: k = j; break
					keys[k] = "green"
					k.self_modulate = green
					
					x.keys()[i].self_modulate = green
					c += 1
				else:
					var k
					for j in keys:
						if j.name == "Button"+s: k = j; break
					if keys[k] == "no":
						keys[k] = "yellow"
						k.self_modulate = yellow
					
					x.keys()[i].self_modulate = yellow
			else:
				var k
				for j in keys:
					if j.name == "Button"+s: k = j; break
				keys[k] = "grey"
				k.self_modulate = grey
		
		if c == 5:
			end_game(true)
		else:
			if lines.find(0) == -1:
				end_game(false)

func end_game(b : bool) -> void:
	$EndGame.visible = true
	$EndGame/word.text = word
	if b: # если игрок выиграл
		pass
	else: # если игрок проиграл
		pass


func _on_new_game_button_down() -> void:
	get_tree().reload_current_scene()
