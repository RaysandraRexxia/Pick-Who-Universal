extends MarginContainer
class_name OptionsWindow


@onready var close_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/CloseButton
@onready var file_path_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/FilePathButton
@onready var image_file_dialog: FileDialog = $MarginContainer/HBoxContainer/VBoxContainer/ImageFileDialog
@onready var chosen_folder_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/ChosenFolderLabel
@onready var fullscreen_button: CheckButton = $MarginContainer/HBoxContainer/VBoxContainer/FullscreenButton
@export var main_scene: MainScene
var folder_target: String = "/Images"
var fullscreen_toggled: bool = false


func _on_close_button_pressed() -> void:
	_close()


func _close():
	main_scene.rules_button.grab_focus()
	main_scene.darken_rect.hide()
	hide()


func _on_file_path_button_pressed() -> void:
	image_file_dialog.popup_centered_ratio(0.8)


func _on_image_file_dialog_dir_selected(dir: String) -> void:
	folder_target = dir
	chosen_folder_label.text = dir
	chosen_folder_label.show()
	main_scene._reset_board()
	close_button.grab_focus()


func _on_fullscreen_button_pressed() -> void:
	fullscreen_toggled = !fullscreen_toggled
	
	if fullscreen_toggled == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		return
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)









#
