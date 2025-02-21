extends Control

@export var green : Color
@export var yellow : Color
@export var grey : Color

var word = "HOUSE"
var keys : Dictionary = {}
var cells : Array = [{}, {}, {}, {}, {}, {}]
var lines = [0,0,0,0,0,0]

func _ready() -> void:
	for i in $KeyBoard/Grid/Line1.get_children():
		keys[i] = "grey"
	for i in $KeyBoard/Grid/Line2.get_children():
		keys[i] = "grey"
	for i in $KeyBoard/Grid/MarginContainer/Line3.get_children():
		keys[i] = "grey"
	
	var x = $Cells.get_children()
	for i in range(len(x)):
		cells[int(i/5)][x[i]] = 0

# СДЕЛАТЬ ПРОВЕРКУ НА ТО ОСТАЛИСЬ ЛИ СВОБОДНЫЕ СТРОКИ ЧТОБЫ НЕ ВЫЛЕЗАЛА ОШИБКА
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
					if keys[k] == "grey":
						keys[k] = "yellow"
						k.self_modulate = yellow
					
					x.keys()[i].self_modulate = yellow
		if c == 5:
			end_game(true)
		else:
			if lines.find(0) == -1:
				end_game(false)

func end_game(b : bool) -> void:
	if b: # если игрок выиграл
		pass
	else: # если игрок проигралz
		pass
	
