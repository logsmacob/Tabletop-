class_name UIStyles
extends RefCounted

const BACKGROUND := Color(0.039216, 0.05098, 0.07451, 1.0)
const PANEL := Color(0.05098, 0.062745, 0.090196, 1.0)
const CARD := Color(0.101961, 0.121569, 0.168627, 1.0)
const CARD_HOVER := Color(0.137255, 0.168627, 0.231373, 1.0)
const MODULE := Color(0.137255, 0.156863, 0.211765, 1.0)
const MODULE_HOVER := Color(0.180392, 0.211765, 0.278431, 1.0)
const NAV_ACTIVE := Color(0.180392, 0.278431, 0.54902, 1.0)
const ACTION := Color(0.2, 0.5, 0.93, 1.0)
const TEXT_PRIMARY := Color(0.968627, 0.976471, 1.0, 1.0)
const TEXT_SECONDARY := Color(0.792157, 0.835294, 0.901961, 1.0)
const TEXT_MUTED := Color(0.701961, 0.745098, 0.835294, 1.0)

static func round_style(fill_color: Color, radius: int, padding: int = 16) -> StyleBoxFlat:
	var style := StyleBoxFlat.new()
	style.bg_color = fill_color
	style.corner_radius_top_left = radius
	style.corner_radius_top_right = radius
	style.corner_radius_bottom_left = radius
	style.corner_radius_bottom_right = radius
	style.content_margin_left = padding
	style.content_margin_top = padding
	style.content_margin_right = padding
	style.content_margin_bottom = padding
	return style

static func tint_color(base_color: Color, amount: float) -> Color:
	return Color(
		clamp(base_color.r + amount, 0.0, 1.0),
		clamp(base_color.g + amount, 0.0, 1.0),
		clamp(base_color.b + amount, 0.0, 1.0),
		base_color.a
	)
