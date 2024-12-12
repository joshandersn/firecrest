extends Node

@onready var parent = get_parent()
@onready var check = $"../Check"

# Moves an entity to a new unoccupied tile.

func use(dir: Vector2) -> void:
	check.target_position = Game.tile_res * dir
	await get_tree().create_timer(0.05).timeout
	if check.is_colliding():
		var body = check.get_collider()
		if "tile" in body and "resident" in body and !body.tile.is_wall and !body.resident:
			parent.position += Game.tile_res * dir
