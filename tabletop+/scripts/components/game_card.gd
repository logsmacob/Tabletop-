class_name GameCard
extends Button

signal selected(game: Dictionary)

@export var title := "Game"
@export_multiline var description := "Game description."
@export var symbol := "D6"
@export var background_color := UIStyles.CARD

var _game: Dictionary = {}

onready var _title_label: Label = $Title
onready var _symbol_label: Label = $Symbol
onready var _description_label: Label = $Description

func _ready() -> void:
	_apply_content()
	pressed.connect(_emit_selected)

func configure(game: Dictionary) -> void:
	_game = game
	title = str(game.get("title", title))
	description = str(game.get("description", description))
	symbol = str(game.get("symbol", symbol))
	background_color = game.get("color", background_color) as Color

	if is_node_ready():
		_apply_content()

func _apply_content() -> void:
	_title_label.text = title
	_symbol_label.text = symbol
	_description_label.text = description

	add_theme_stylebox_override("normal", UIStyles.round_style(background_color, 24))
	add_theme_stylebox_override("hover", UIStyles.round_style(UIStyles.tint_color(background_color, 0.12), 24))
	add_theme_stylebox_override("pressed", UIStyles.round_style(UIStyles.tint_color(background_color, -0.04), 24))
	add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)

func _emit_selected() -> void:
	selected.emit(_game)
