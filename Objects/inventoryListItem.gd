extends Button

var entity: ResEntity
var origin

signal add_to_inv
signal equip_item
signal eat_item

func _ready() -> void:
	if entity:
		text = entity.tag
		icon = entity.artwork
	else:
		push_warning("No Entity provided in InventoryListItem")

func _on_button_pressed() -> void:
	emit_signal("equip_item", origin, entity)

func _on_eat_pressed() -> void:
	emit_signal("eat_item", origin, entity)

func _on_pressed() -> void:
	emit_signal("add_to_inv", origin, entity)
