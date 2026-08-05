class_name HomeScreen
extends Control

signal game_selected(game: Dictionary)

@export var game_card_scene: PackedScene

var _grid: GridContainer

func _ready() -> void:
	if game_card_scene == null:
		game_card_scene = preload("res://scenes/components/game_card.tscn")

	_build_layout()
	populate_games(GameCatalog.GAMES)

func populate_games(games: Array) -> void:
	for child in _grid.get_children():
		child.queue_free()

	for game in games:
		var game_data: Dictionary = game
		var card: GameCard = game_card_scene.instantiate() as GameCard
		card.configure(game_data)
		card.selected.connect(_on_game_selected)
		_grid.add_child(card)

func _build_layout() -> void:
	var layout := VBoxContainer.new()
	layout.set_anchors_preset(Control.PRESET_FULL_RECT)
	layout.add_theme_constant_override("separation", 14)
	add_child(layout)

	var intro := PanelContainer.new()
	intro.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.CARD, 24))
	layout.add_child(intro)

	var intro_content := VBoxContainer.new()
	intro_content.add_theme_constant_override("separation", 6)
	intro.add_child(intro_content)

	var title_label := Label.new()
	title_label.text = "Game Library"
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", 24)
	title_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	intro_content.add_child(title_label)

	var body_label := Label.new()
	body_label.text = "Tap a game module to open its profile, then jump into rules, scoreboard, or remix screens."
	body_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	body_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	body_label.add_theme_font_size_override("font_size", 14)
	body_label.add_theme_color_override("font_color", UIStyles.TEXT_SECONDARY)
	intro_content.add_child(body_label)

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	layout.add_child(scroll)

	_grid = GridContainer.new()
	_grid.columns = 2
	_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_grid.add_theme_constant_override("h_separation", 12)
	_grid.add_theme_constant_override("v_separation", 12)
	scroll.add_child(_grid)

func _on_game_selected(game: Dictionary) -> void:
	game_selected.emit(game)
