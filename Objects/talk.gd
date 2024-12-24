extends Node

@onready var parent = get_parent()
func use(target) -> void:
	var e = target.entity
	var content := ""
	if e.health < 0:
		Game.game_log.emit(str(target.entity.tag, " is dead, and has nothing to say"))
	elif e.savagery >= 3:
		content = str("*sniff* It's been months since I had a [color=green]", parent.entity.tag, "[/color]")
		Game.start_conversation.emit(parent, target, content)
	elif e.savagery >= 2:
		content = str("You look lost friend.")
		Game.start_conversation.emit(parent, target, content)
	elif e.savagery >= 0:
		content = str("what is a ", parent.entity.tag, " like you doing here?")
		Game.start_conversation.emit(parent, target, content)
	else:
		Game.game_log.emit(str(target.entity.tag, " is not in the mood for a conversation"))
	
	
	
