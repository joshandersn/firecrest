extends Node

func use(body) -> void:
	if "entity" in body:
		if body.entity.health <= 0:
			Game.opened_storage_contents = body.entity.storage
			Game.emit_signal("ui_update")
