extends Button

var entity: ResEntity
var origin

signal add_to_inv

func _ready() -> void:
	if entity:
		text = entity.tag
		icon = entity.artwork
	else:
		push_warning("No Entity provided in InventoryListItem")


func _on_pressed() -> void:
	emit_signal("add_to_inv", origin, entity)
