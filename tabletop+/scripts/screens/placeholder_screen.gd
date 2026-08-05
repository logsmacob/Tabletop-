class_name PlaceholderScreen
extends Control

@export var screen_title := "Screen"
@export_multiline var screen_description := "Coming soon."
@export_multiline var placeholder_text := "Details coming soon."

var _title_label: Label
var _description_label: Label
var _placeholder_label: Label

func _ready() -> void:
	_build_layout()

func configure(title: String, description: String, placeholder: String) -> void:
	screen_title = title
	screen_description = description
	placeholder_text = placeholder

	if is_node_ready():
		_refresh_text()

func _build_layout() -> void:
	var layout := VBoxContainer.new()
	layout.set_anchors_preset(Control.PRESET_FULL_RECT)
	layout.add_theme_constant_override("separation", 14)
	add_child(layout)

	var card := PanelContainer.new()
	card.size_flags_vertical = Control.SIZE_EXPAND_FILL
	card.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.CARD, 24))
	layout.add_child(card)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 10)
	card.add_child(content)

	_title_label = Label.new()
	_title_label.add_theme_font_size_override("font_size", 28)
	_title_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	content.add_child(_title_label)

	_description_label = Label.new()
	_description_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_description_label.add_theme_font_size_override("font_size", 17)
	_description_label.add_theme_color_override("font_color", UIStyles.TEXT_SECONDARY)
	content.add_child(_description_label)

	var placeholder := PanelContainer.new()
	placeholder.name = "Placeholder"
	placeholder.size_flags_vertical = Control.SIZE_EXPAND_FILL
	placeholder.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.MODULE, 20))
	content.add_child(placeholder)

	_placeholder_label = Label.new()
	_placeholder_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_placeholder_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_placeholder_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_placeholder_label.add_theme_font_size_override("font_size", 16)
	_placeholder_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	placeholder.add_child(_placeholder_label)

	_refresh_text()

func _refresh_text() -> void:
	_title_label.text = screen_title
	_description_label.text = screen_description
	_placeholder_label.text = placeholder_text
