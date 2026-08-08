class_name GameProfileScreen
extends Control

signal back_requested
signal module_selected(module_name: String)

var current_game: Dictionary = {}

var _profile_card: PanelContainer
var _chip_label: Label
var _title_label: Label
var _description_label: Label

func _ready() -> void:
	_build_layout()

func show_game(game: Dictionary) -> void:
	current_game = game
	var accent: Color = game.get("color", UIStyles.CARD) as Color

	_chip_label.text = str(game.get("symbol", "D6")) + "  Game Profile"
	_title_label.text = str(game.get("title", "Game"))
	_description_label.text = str(game.get("description", ""))
	_profile_card.add_theme_stylebox_override("panel", UIStyles.round_style(accent, 24))

func _build_layout() -> void:
	var layout := VBoxContainer.new()
	layout.set_anchors_preset(Control.PRESET_FULL_RECT)
	layout.add_theme_constant_override("separation", 14)
	add_child(layout)

	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	layout.add_child(top_bar)

	var back_button := Button.new()
	back_button.text = "Back to Library"
	back_button.add_theme_font_size_override("font_size", 15)
	back_button.add_theme_stylebox_override("normal", UIStyles.round_style(UIStyles.PANEL, 22, 12))
	back_button.add_theme_stylebox_override("hover", UIStyles.round_style(UIStyles.NAV_ACTIVE, 22, 12))
	back_button.add_theme_stylebox_override("pressed", UIStyles.round_style(UIStyles.PANEL, 22, 12))
	back_button.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	back_button.pressed.connect(func() -> void: back_requested.emit())
	top_bar.add_child(back_button)

	_profile_card = PanelContainer.new()
	_profile_card.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.CARD, 24))
	layout.add_child(_profile_card)

	var profile_content := VBoxContainer.new()
	profile_content.add_theme_constant_override("separation", 10)
	_profile_card.add_child(profile_content)

	_chip_label = Label.new()
	_chip_label.add_theme_font_size_override("font_size", 26)
	_chip_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	profile_content.add_child(_chip_label)

	_title_label = Label.new()
	_title_label.add_theme_font_size_override("font_size", 42)
	_title_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	profile_content.add_child(_title_label)

	_description_label = Label.new()
	_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_description_label.add_theme_font_size_override("font_size", 26)
	_description_label.add_theme_color_override("font_color", UIStyles.TEXT_SECONDARY)
	profile_content.add_child(_description_label)

	var module_grid := GridContainer.new()
	module_grid.columns = 2
	module_grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	module_grid.add_theme_constant_override("h_separation", 12)
	module_grid.add_theme_constant_override("v_separation", 12)
	layout.add_child(module_grid)

	module_grid.add_child(_create_module_button("Game Rules", "rules"))
	module_grid.add_child(_create_module_button("Scoreboard", "scoreboard"))
	module_grid.add_child(_create_module_button("Remix", "remix"))

func _create_module_button(label: String, module_name: String) -> Button:
	var button := Button.new()
	button.text = label
	button.custom_minimum_size = Vector2(0.0, 92.0)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", 26)
	button.add_theme_stylebox_override("normal", UIStyles.round_style(UIStyles.MODULE, 20))
	button.add_theme_stylebox_override("hover", UIStyles.round_style(UIStyles.MODULE_HOVER, 20))
	button.add_theme_stylebox_override("pressed", UIStyles.round_style(UIStyles.MODULE, 20))
	button.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	button.pressed.connect(func() -> void: module_selected.emit(module_name))
	return button
