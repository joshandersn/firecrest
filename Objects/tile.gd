extends Node2D

@export var tile: ResTile
var resident: Node2D

func refresh() -> void:
	if tile:
		$Sprite.texture = tile.texture
		$Label.text = tile.tag

func _ready() -> void:
	refresh()
