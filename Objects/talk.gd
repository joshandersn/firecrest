extends Node

@onready var parent = get_parent()
func use(target) -> void:
	var e = target.entity
	var content := ""
	if e.health < 0:
		Game.game_log.emit(str(target.entity.tag, " is dead, and has nothing to say"))
	elif e.savagery > 2:
		content = "*growl*"
		Game.start_conversation.emit(parent, target, content)
	else:
		Game.game_log.emit(str(target.entity.tag, " is not in the mood for a conversation"))
	
	
	
