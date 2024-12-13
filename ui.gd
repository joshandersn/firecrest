extends CanvasLayer

@onready var inv_list_item = load("res://Objects/inventoryListItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.ui_update.connect(update_ui)

func inv_item_clicked(item) -> void:
	Game.players[0].entity.storage.append(item)
	Game.opened_storage_containers[0].entity.storage.erase(item)
	Game.opened_storage_contents.erase(item)
	update_ui()

func update_ui() -> void:
	$HUD/EntityInspect.text = str(Game.ui_inspect_entity_description)
	$HUD/TileInspect.text = str(Game.ui_inspect_tile_description)
	for leftover in $HUD/OpenedStorageList.get_children():
		leftover.queue_free()
	for item in Game.opened_storage_contents:
		var item_inst = inv_list_item.instantiate()
		item_inst.entity = item
		item_inst.add_to_inv.connect(inv_item_clicked)
		$HUD/OpenedStorageList.add_child(item_inst)
		$HUD/OpenedStorageList.get_child(0).grab_focus()
	
	$HUD/InvBG.visible = !(Game.opened_storage_contents == [])
