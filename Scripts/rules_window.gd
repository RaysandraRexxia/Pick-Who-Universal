extends MarginContainer
class_name RulesWindow


@export var main_scene: MainScene
@onready var close_button: Button = $MarginContainer/VBoxContainer/PathHBox/CloseButton


func _on_close_button_pressed() -> void:
	_close()


func _close():
	main_scene.rules_button.grab_focus()
	main_scene.darken_rect.hide()
	hide()
