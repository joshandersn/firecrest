extends Node

func use(body, user) -> void:
	if "entity" in body:
		if body.entity.health <= 0:
			if user.is_player:
				Game.opened_storage_contents = body.entity.storage
				Game.opened_storage_containers.append(body)
				Game.emit_signal("ui_update")
				if body.entity.storage == []:
					if user.entity.strength >= body.entity.mass:
						user.entity.storage.append(body.entity)
						Game.opened_storage_containers = []
						body.queue_free()
					else:
						Game.emit_signal("game_log", str(body.entity.tag, " is too heavy (", body.entity.mass, ") for ", user.entity.tag, " to pick up!"))
			else:
				user.entity.storage.append(body.entity)
				Game.players.erase(body)
				body.queue_free()
				Game.emit_signal("game_log", str(user.entity.tag, " has consumed ", body.entity.tag))
		else:
			var damage = user.entity.mass + user.entity.sharpness
			if user.entity.wielded:
				damage += user.entity.wielded.sharpness + user.entity.wielded.mass
			body.entity.health -= damage
			Game.emit_signal("game_log", str(user.entity.tag, " hit ", body.entity.tag, " for ", damage, " Damage"))
			body.refresh()
