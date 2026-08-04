extends Control

var nav_normal_style: StyleBoxFlat
var nav_active_style: StyleBoxFlat

@onready var pages := {
	"home": $SafeMargin/Shell/Pages/HomePage,
	"leaderboard": $SafeMargin/Shell/Pages/LeaderboardPage,
	"account": $SafeMargin/Shell/Pages/AccountPage,
}

@onready var nav_buttons := {
	"home": $SafeMargin/Shell/BottomNav/NavRow/HomeButton,
	"leaderboard": $SafeMargin/Shell/BottomNav/NavRow/LeaderboardButton,
	"account": $SafeMargin/Shell/BottomNav/NavRow/AccountButton,
}

var current_page := "home"

func _ready() -> void:
	nav_normal_style = _make_nav_style(Color(0.0901961, 0.1058824, 0.145098, 1))
	nav_active_style = _make_nav_style(Color(0.1803922, 0.2784314, 0.5490196, 1))

	$SafeMargin/Shell/BottomNav/NavRow/HomeButton.pressed.connect(_show_page.bind("home"))
	$SafeMargin/Shell/BottomNav/NavRow/LeaderboardButton.pressed.connect(_show_page.bind("leaderboard"))
	$SafeMargin/Shell/BottomNav/NavRow/AccountButton.pressed.connect(_show_page.bind("account"))
	_show_page("home")

func _show_page(page_name: String) -> void:
	current_page = page_name
	for name in pages.keys():
		pages[name].visible = name == page_name
		var button = nav_buttons[name]
		button.button_pressed = name == page_name
		if name == page_name:
			button.add_theme_stylebox_override("normal", nav_active_style)
			button.add_theme_stylebox_override("hover", nav_active_style)
			button.add_theme_stylebox_override("pressed", nav_active_style)
			button.add_theme_color_override("font_color", Color.WHITE)
		else:
			button.add_theme_stylebox_override("normal", nav_normal_style)
			button.add_theme_stylebox_override("hover", nav_normal_style)
			button.add_theme_stylebox_override("pressed", nav_normal_style)
			button.add_theme_color_override("font_color", Color(0.878, 0.906, 0.949))

func _make_nav_style(fill_color: Color) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill_color
	style.corner_radius_top_left = 22
	style.corner_radius_top_right = 22
	style.corner_radius_bottom_left = 22
	style.corner_radius_bottom_right = 22
	style.content_margin_left = 12
	style.content_margin_top = 10
	style.content_margin_right = 12
	style.content_margin_bottom = 10
	return style
