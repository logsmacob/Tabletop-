class_name TabletopApp
extends Control

@export var app_title := "Tabletop+"
@export var app_subtitle := "Scorekeeper - House Rules - Replayable play"

const HOME_SCREEN_SCENE := preload("res://scenes/screens/home_screen.tscn")
const PROFILE_SCREEN_SCENE := preload("res://scenes/screens/game_profile_screen.tscn")
const MODULE_SCREEN_SCENE := preload("res://scenes/screens/module_screen.tscn")
const PLACEHOLDER_SCREEN_SCENE := preload("res://scenes/screens/placeholder_screen.tscn")

var _pages: Dictionary = {}
var _nav_buttons: Dictionary = {}
var _current_game: Dictionary = {}
var _pages_container: Control
var _ui_scale := 1.0

func _compute_ui_scale() -> void:
	# Scale relative to a 1080px design width; clamp so extremes remain usable
	var width := get_viewport_rect().size.x
	_ui_scale = clamp(width / 1080.0, 0.8, 1.6)

func _s(value: int) -> int:
	return int(value * _ui_scale)

func _ready() -> void:
	_compute_ui_scale()
	_build_app_shell()
	_create_screens()
	_show_page("home")

func _build_app_shell() -> void:
	var background := ColorRect.new()
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.color = UIStyles.BACKGROUND
	add_child(background)

	var safe_margin := MarginContainer.new()
	safe_margin.set_anchors_preset(Control.PRESET_FULL_RECT)
	safe_margin.add_theme_constant_override("margin_left", 24)
	safe_margin.add_theme_constant_override("margin_top", 28)
	safe_margin.add_theme_constant_override("margin_right", 24)
	safe_margin.add_theme_constant_override("margin_bottom", 22)
	add_child(safe_margin)

	var shell := VBoxContainer.new()
	shell.add_theme_constant_override("separation", 12)
	safe_margin.add_child(shell)

	shell.add_child(_create_header())

	_pages_container = Control.new()
	_pages_container.size_flags_vertical = Control.SIZE_EXPAND_FILL
	shell.add_child(_pages_container)

	shell.add_child(_create_bottom_nav())

func _create_header() -> PanelContainer:
	var header := PanelContainer.new()
	header.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.PANEL, 28, 18))

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 6)
	header.add_child(content)

	var title_label := Label.new()
	title_label.text = app_title
	title_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	title_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	title_label.add_theme_font_size_override("font_size", _s(42))  # scaled for device
	title_label.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
	content.add_child(title_label)

	var subtitle_label := Label.new()
	subtitle_label.text = app_subtitle
	subtitle_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	subtitle_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	subtitle_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	subtitle_label.add_theme_font_size_override("font_size", _s(18))  # scaled for device
	subtitle_label.add_theme_color_override("font_color", UIStyles.TEXT_MUTED)
	content.add_child(subtitle_label)

	return header

func _create_bottom_nav() -> PanelContainer:
	var nav := PanelContainer.new()
	nav.add_theme_stylebox_override("panel", UIStyles.round_style(UIStyles.PANEL, 28, 18))

	var nav_row := HBoxContainer.new()
	nav_row.add_theme_constant_override("separation", 10)
	nav.add_child(nav_row)

	_add_nav_button(nav_row, "home", "Home")
	_add_nav_button(nav_row, "leaderboard", "Leaderboard")
	_add_nav_button(nav_row, "account", "Account")

	return nav

func _add_nav_button(parent: HBoxContainer, page_name: String, label: String) -> void:
	var button := Button.new()
	button.text = label
	button.toggle_mode = true
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.add_theme_font_size_override("font_size", _s(20))  # scaled for device
	button.pressed.connect(_show_page.bind(page_name))
	parent.add_child(button)
	_nav_buttons[page_name] = button

func _create_screens() -> void:
	var home_screen: HomeScreen = HOME_SCREEN_SCENE.instantiate() as HomeScreen
	_add_page("home", home_screen)
	home_screen.game_selected.connect(_open_game_profile)

	var profile_screen: GameProfileScreen = PROFILE_SCREEN_SCENE.instantiate() as GameProfileScreen
	_add_page("game_profile", profile_screen)
	profile_screen.back_requested.connect(_show_page.bind("home"))
	profile_screen.module_selected.connect(_open_module)

	var module_screen: ModuleScreen = MODULE_SCREEN_SCENE.instantiate() as ModuleScreen
	_add_page("module", module_screen)
	module_screen.back_requested.connect(_show_page.bind("game_profile"))

	var leaderboard_screen: PlaceholderScreen = PLACEHOLDER_SCREEN_SCENE.instantiate() as PlaceholderScreen
	_add_page("leaderboard", leaderboard_screen)
	leaderboard_screen.configure(
		"Leaderboard",
		"Friends, score runs, and game nights will show up here later.",
		"No scores yet\n\nThis is just a polished placeholder screen for now."
	)

	var account_screen: PlaceholderScreen = PLACEHOLDER_SCREEN_SCENE.instantiate() as PlaceholderScreen
	_add_page("account", account_screen)
	account_screen.configure(
		"Account",
		"Profile, saved games, house rules, and settings can land here later.",
		"Account details coming soon"
	)

func _add_page(page_name: String, page: Control) -> void:
	page.set_anchors_preset(Control.PRESET_FULL_RECT)
	page.visible = false
	_pages_container.add_child(page)
	_pages[page_name] = page

func _open_game_profile(game: Dictionary) -> void:
	_current_game = game
	var profile_screen: GameProfileScreen = _pages["game_profile"]
	profile_screen.show_game(game)
	_show_page("game_profile")

func _open_module(module_name: String) -> void:
	var module_screen: ModuleScreen = _pages["module"]
	module_screen.show_module(_current_game, module_name)
	_show_page("module")

func _show_page(page_name: String) -> void:
	for _name in _pages.keys():
		_pages[_name].visible = _name == page_name

	_update_bottom_nav(page_name)

func _update_bottom_nav(page_name: String) -> void:
	var active_nav_page := page_name
	if page_name == "game_profile" or page_name == "module":
		active_nav_page = "home"

	for _name in _nav_buttons.keys():
		var button: Button = _nav_buttons[_name]
		var is_active: bool = _name == active_nav_page
		var style_color: Color = UIStyles.NAV_ACTIVE if is_active else UIStyles.PANEL

		button.button_pressed = is_active
		button.add_theme_stylebox_override("normal", UIStyles.round_style(style_color, 22, 12))
		button.add_theme_stylebox_override("hover", UIStyles.round_style(style_color, 22, 12))
		button.add_theme_stylebox_override("pressed", UIStyles.round_style(style_color, 22, 12))
		button.add_theme_color_override("font_color", UIStyles.TEXT_PRIMARY)
