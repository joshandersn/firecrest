extends Node2D

@export var tile: ResTile
var resident: Node2D

func refresh() -> void:
	if tile:
		$Sprite.texture = tile.texture

func _ready() -> void:
	refresh()

func _on_mouse_entered() -> void:
	Game.ui_inspect_tile_description = str(tile.tag)
	Game.emit_signal("ui_update")
