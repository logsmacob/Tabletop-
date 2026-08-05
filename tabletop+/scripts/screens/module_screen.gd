class_name ModuleScreen
extends Control

signal back_requested

var _module_card: PanelContainer
var _chip_label: Label
var _title_label: Label
var _description_label: Label

func _ready() -> void:
	_build_layout()

func show_module(game: Dictionary, module_name: String) -> void:
	var module: Dictionary = GameCatalog.MODULES.get(module_name, {})
	var accent: Color = game.get("color", UIStyles.CARD) as Color
	var game_title := str(game.get("title", "Game"))
	var module_title := str(module.get("title", "Module"))

	_chip_label.text = str(game.get("symbol", "D6")) + "  " + module_title
	_title_label.text = game_title + " - " + module_title
	_description_label.text = str(module.get("description", ""))
	_module_card.add_theme_stylebox_override("panel", UIStyles.round_style(accent, 24))

func _build_layout() -> void:
	var layout := VBoxContainer.new()
	layout.set_anchors_preset(Control.PRESET_FULL_RECT)
	layout.add_theme_constant_override("separation", 14)
	add_child(layout)

	var top_bar := HBoxContainer.new()
	top_bar.add_theme_constant_override("separation", 10)
	layout.add_child(top_bar)

	var back_button := Button.new()
	back_button.text = "Back to Profile"
	back_button.add_theme_font_size_override("font_size", 16)
	back_button.add_theme_stylebox_override("normal", UIStyles.round_style(UIStyles.PANEL, 22, 12))
	back_button.add_theme_stylebox_override("hover", UIStyles.round_style(UIStyles.NAV_ACTIVE, 22, 12))
	back_button.add_theme_stylebox_override("pressed", UIStyles.round_style(UIStyles.PANEL, 22, 12))
	back_button.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	back_button.pressed.connect(func() -> void: back_requested.emit())
	top_bar.add_child(back_button)

	_module_card = PanelContainer.new()
	_module_card.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.CARD, 24))
	layout.add_child(_module_card)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 10)
	_module_card.add_child(content)

	_chip_label = Label.new()
	_chip_label.add_theme_font_size_override("font_size", 16)
	_chip_label.add_theme_color_override("font_color", Color(0.643137, 0.729412, 1.0, 1.0))
	content.add_child(_chip_label)

	_title_label = Label.new()
	_title_label.add_theme_font_size_override("font_size", 26)
	_title_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	content.add_child(_title_label)

	_description_label = Label.new()
	_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_description_label.add_theme_font_size_override("font_size", 15)
	_description_label.add_theme_color_override("font_color", UIStyles.TEXT_SECONDARY)
	content.add_child(_description_label)
