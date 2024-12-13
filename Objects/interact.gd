extends Node

func use(body) -> void:
	if "entity" in body:
		if body.entity.health <= 0:
			Game.opened_storage_contents = body.entity.storage
			Game.opened_storage_containers.append(body)
			Game.emit_signal("ui_update")
