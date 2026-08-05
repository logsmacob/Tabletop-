class_name GameCard
extends Button

signal selected(game: Dictionary)

@export var title := "Game"
@export_multiline var description := "Game description."
@export var symbol := "D6"
@export var background_color := UIStyles.CARD

var _game: Dictionary = {}
var _title_label: Label
var _symbol_label: Label
var _description_label: Label

func _ready() -> void:
	_build_layout()
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

func _build_layout() -> void:
	custom_minimum_size = Vector2(0.0, 184.0)
	size_flags_horizontal = Control.SIZE_EXPAND_FILL
	focus_mode = Control.FOCUS_ALL
	text = ""
	add_theme_constant_override("h_separation", 0)

	var content := VBoxContainer.new()
	content.set_anchors_preset(Control.PRESET_FULL_RECT)
	content.mouse_filter = Control.MOUSE_FILTER_IGNORE
	content.add_theme_constant_override("separation", 6)
	add_child(content)

	var top_spacer := Control.new()
	top_spacer.custom_minimum_size = Vector2(0.0, 4.0)
	content.add_child(top_spacer)

	_title_label = Label.new()
	_title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_title_label.add_theme_font_size_override("font_size", 19)
	_title_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	content.add_child(_title_label)

	_symbol_label = Label.new()
	_symbol_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_symbol_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_symbol_label.add_theme_font_size_override("font_size", 38)
	_symbol_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	content.add_child(_symbol_label)

	_description_label = Label.new()
	_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_description_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_description_label.add_theme_font_size_override("font_size", 12)
	_description_label.add_theme_color_override("font_color", UIStyles.TEXT_SECONDARY)
	content.add_child(_description_label)

	var footer := Label.new()
	footer.text = "Tap to open"
	footer.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	footer.add_theme_font_size_override("font_size", 13)
	footer.add_theme_color_override("font_color", Color(0.643137, 0.729412, 1.0, 1.0))
	content.add_child(footer)

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
