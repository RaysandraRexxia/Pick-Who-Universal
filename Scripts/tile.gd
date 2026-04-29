extends Control
class_name Tile


const BACK = preload("uid://dsk2ncsiylwij")
@onready var frontimage: String
@onready var name_label: Label = $NameLabel
@onready var tile_texture: TextureRect = $TileTexture
@onready var tile: Tile = $"."
var front_texture: ImageTexture
var is_up: bool = true
var tile_id: int = 0
var tile_name: String
signal change_count(number)


func _set_image(image: String):
	if is_up == true:
		frontimage = image
		var front_image = Image.load_from_file(frontimage)
		front_texture = ImageTexture.create_from_image(front_image)
		tile_texture.texture = front_texture
	else:
		tile_texture.texture = BACK


func _on_tile_button_pressed() -> void:
	if is_up == true:
		is_up = false
		change_count.emit(-1)
	else:
		is_up = true
		change_count.emit(1)
	_set_image(frontimage)
