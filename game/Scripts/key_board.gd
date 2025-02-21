extends Control

func _ready() -> void:
	for i in $Grid/Line1.get_children():
		i.button_down.connect($"..".key_click.bind(str(i.name)[-1]))
	for i in $Grid/Line2.get_children():
		i.button_down.connect($"..".key_click.bind(str(i.name)[-1]))
	for i in $Grid/MarginContainer/Line3.get_children():
		i.button_down.connect($"..".key_click.bind(str(i.name)[-1]))
	$ButtonDelete.button_down.connect($"..".delete)
	$ButtonEnter.button_down.connect($"..".enter)
