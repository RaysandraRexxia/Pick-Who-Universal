extends MarginContainer
class_name ControlsWindow


@onready var close_button: Button = $MarginContainer/VBoxContainer/CloseButton
@export var options_window: OptionsWindow


func _on_close_button_pressed() -> void:
	options_window.controls_button.grab_focus()
	hide()
