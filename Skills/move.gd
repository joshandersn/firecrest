extends Node

@onready var parent = get_parent()
@onready var entity_check = $"../EntityCheck"
@onready var tile_check = $"../TileCheck"

# Moves an entity to a new unoccupied tile.

func use(dir: Vector2) -> void:
	tile_check.target_position = Game.tile_res * dir
	entity_check.target_position = Game.tile_res * dir
	await get_tree().create_timer(0.05).timeout
	if entity_check.is_colliding():
		var entity_body = entity_check.get_collider()
		# Interact
		if parent.is_player:
			if entity_body.is_in_group("entity"):
				print(entity_body)
	elif tile_check.is_colliding():
		var tile_body = tile_check.get_collider()

		if "tile" in tile_body and !tile_body.tile.is_wall:
				parent.position += Game.tile_res * dir
