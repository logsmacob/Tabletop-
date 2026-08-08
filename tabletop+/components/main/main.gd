extends Control

@onready var pages = $SafeMargin/Shell/Pages
@onready var bottom_nav = $SafeMargin/Shell/BottomNav


func _ready() -> void:
	bottom_nav.screen_chosen.connect(_on_screen_chosen)


func _on_screen_chosen(index: int) -> void:
	for page in pages.get_children():
		page.hide()

	pages.get_child(index).show()

	print("Selected page: ", index)
