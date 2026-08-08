extends PanelContainer

@onready var nav_row: HBoxContainer = $MarginContainer/NavRow
@onready var button_list: Array[Button] = []

signal screen_chosen(index: int)

func _ready() -> void:
	for child: Node in nav_row.get_children():
		if child is Button:
			button_list.append(child)
			connect_signal(child, button_list.size() - 1)

func connect_signal(child: Button, index: int) -> void:
	child.pressed.connect(_on_button_pressed.bind(index))

func _on_button_pressed(index: int) -> void:
	for child in button_list:
		child.button_pressed = false
	button_list[index].button_pressed = true
	screen_chosen.emit(index)
