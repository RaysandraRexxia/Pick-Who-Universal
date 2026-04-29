extends Control
class_name MainScene


@onready var tile_template: PackedScene = preload("uid://bb44ie7pxut7c")
@onready var grid_container: GridContainer = $ScrollContainer/GridContainer
@onready var darken_rect: ColorRect = $DarkenRect
@onready var chosen_card_window: ChosenCardWindow = $DarkenRect/ChosenCardWindow
@onready var rules_window: RulesWindow = $DarkenRect/RulesWindow
@onready var options_window: OptionsWindow = $DarkenRect/OptionsWindow
@onready var fade_box: ColorRect = $FadeBox
@onready var see_tile_button: Button = $BottomHBoxRight/SeeTileButton
@onready var rules_button: Button = $BottomHBoxRight/RulesButton
@onready var remaining_label: Label = $BottomLeftMargin/BottomHBoxLeft/RemainingLabel
@onready var total_label: Label = $BottomLeftMargin/BottomHBoxLeft/TotalLabel
var image_list: Array[String] = []
var chosen_tile: Tile
var weight: float = 0.1
var remaining_tile_count: int = 0


func _ready() -> void:
	_reset_board()


func _process(delta: float) -> void:
	_fade_in(delta)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released_by_event("SeeChosenCard", event):
		if chosen_card_window.visible == false:
			_show_chosen_card()
			return
		else:
			chosen_card_window._close()
			return
	if Input.is_action_just_released_by_event("SeeRules", event):
		if rules_window.visible == false:
			_show_rules()
			return
		else:
			rules_window._close()
			return
	if Input.is_action_just_released_by_event("SeeOptions", event):
		if options_window.visible == false:
			_show_options()
			return
		else:
			options_window._close()
			return


func _load_images():
	image_list.clear()
	if options_window.folder_target != "/Images":
		for file_name in DirAccess.get_files_at(options_window.folder_target):
			image_list.append(options_window.folder_target + "/" + file_name)
	else:
		for file_name in DirAccess.get_files_at("user://Images"):
			image_list.append(OS.get_user_data_dir() + "/Images/" + file_name)


func _make_tiles():
	while grid_container.get_child_count(false) > 0:
		for c in grid_container.get_children(false):
			grid_container.remove_child(c)
	
	print(image_list)
	for i in image_list:
		var tile_inst = tile_template.instantiate()
		grid_container.add_child(tile_inst)
		tile_inst._set_image(i)
		tile_inst.tile_id = image_list.find(i) + 1
		tile_inst.tile_name = i.get_basename().get_file()
		tile_inst.name_label.text = tile_inst.tile_name
		tile_inst.change_count.connect(_change_count)
		print(str(tile_inst.tile_id) + ": " + tile_inst.tile_name)
	total_label.text = str(image_list.size())
	remaining_tile_count = image_list.size()
	remaining_label.text = str(remaining_tile_count)


func _change_count(number: int):
	remaining_tile_count += number
	remaining_label.text = str(remaining_tile_count)


func _reset_board():
	fade_box.show()
	fade_box.color = Color(0, 0, 0, 1)
	rules_button.grab_focus()
	_load_images()
	_make_tiles()
	var randint = randi_range(1, image_list.size())
	for c in grid_container.get_children(false):
		if c.tile_id == randint:
			chosen_tile = c
			break


func _fade_in(delta):
	if fade_box.visible == false:
		return
	elif fade_box.color == Color(0, 0, 0, 0):
		fade_box.hide()
		return
	else:
		fade_box.color = fade_box.color.lerp(Color(0, 0, 0, 0), delta)


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_see_tile_button_pressed() -> void:
	_show_chosen_card()


func _on_rules_button_pressed() -> void:
	_show_rules()


func _show_chosen_card():
	options_window.hide()
	rules_window.hide()
	chosen_card_window._set_chosen_tile(chosen_tile)
	darken_rect.show()
	chosen_card_window.show()
	chosen_card_window.close_button.grab_focus()


func _show_rules():
	options_window.hide()
	chosen_card_window.hide()
	darken_rect.show()
	rules_window.show()
	rules_window.close_button.grab_focus()


func _show_options():
	options_window.show()
	chosen_card_window.hide()
	darken_rect.show()
	rules_window.hide()
	options_window.close_button.grab_focus()


func _on_reset_button_pressed() -> void:
	_reset_board()


func _on_options_button_pressed() -> void:
	_show_options()
