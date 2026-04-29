extends MarginContainer
class_name ChosenCardWindow


@onready var tile_texture: TextureRect = $MarginContainer/VBoxContainer/MarginContainer/TileTexture
@onready var card_label: Label = $MarginContainer/VBoxContainer/CardLabel
@onready var close_button: Button = $MarginContainer/VBoxContainer/CloseButton
@export var main_scene: MainScene
var tile_id: int = 0
var tile_name: String


func _set_chosen_tile(tile: Tile):
	tile_id = tile.tile_id
	tile_name = tile.tile_name
	tile_texture.texture = tile.front_texture
	card_label.text = ("Your Tile is: " + tile_name)


func _on_close_button_pressed() -> void:
	_close()


func _close():
	main_scene.see_tile_button.grab_focus()
	main_scene.darken_rect.hide()
	hide()
