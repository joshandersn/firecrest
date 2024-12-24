extends Node

@onready var parent = get_parent()
func use(target) -> void:
	var e = target.entity
	if e.health < 0:
		Game.game_log.emit(str(target.entity.tag, " is dead, and has nothing to say"))
	elif e.savagry > 2:
		pass
		Game.start_conversation(parent, target)
	else:
		Game.game_log.emit(str(target.entity.tag, " is not in the mood for a conversation"))
	
	
	
