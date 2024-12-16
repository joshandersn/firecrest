extends Node

func use(body) -> void:
	if "entity" in body:
		if body.entity.health <= 0:
			Game.opened_storage_contents = body.entity.storage
			Game.opened_storage_containers.append(body)
			Game.emit_signal("ui_update")
		else:
			var player = Game.players[0].entity
			var damage = player.mass + player.sharpness
			if player.wielded:
				damage += player.wielded.sharpness + player.wielded.mass
			body.entity.health -= damage
			print("you hit ", body.entity.tag, "(", body.entity.health, ") for ", damage, " Damage")
