extends Button

var entity: ResEntity

func _ready() -> void:
	if entity:
		text = entity.tag
		icon = entity.artwork
	else:
		push_warning("No Entity provided in InventoryListItem")
