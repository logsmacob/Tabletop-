class_name GameCard
extends Button

signal selected(game: Dictionary)

var _game: Dictionary = {}

func _ready() -> void:
	pressed.connect(_emit_selected)

func configure(game: Dictionary) -> void:
	_game = game

func _emit_selected() -> void:
	selected.emit(_game)
