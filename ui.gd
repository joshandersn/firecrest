extends CanvasLayer

@onready var storage_list_item = load("res://Objects/inventoryListItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.ui_update.connect(update_ui)

func toggle_inventory_view() -> void:
	$HUD/PlayerInvBG.visible = !$HUD/PlayerInvBG.visible
	update_ui()

func storage_item_clicked(item) -> void:
	Game.players[0].entity.storage.append(item)
	Game.opened_storage_containers[0].entity.storage.erase(item)
	Game.opened_storage_contents.erase(item)
	update_ui()

func update_ui() -> void:
	$HUD/EntityInspect.text = str(Game.ui_inspect_entity_description)
	$HUD/TileInspect.text = str(Game.ui_inspect_tile_description)
	update_storage_list($HUD/OpenedStorageList, Game.opened_storage_contents)
	if Game.players:
		update_storage_list($HUD/PlayerInvBG/PlayerStorageList, Game.players[0].entity.storage)
	$HUD/StorageBG.visible = !(Game.opened_storage_contents == [])

func update_storage_list(list, contents) -> void:
	for leftover in list.get_children():
		leftover.queue_free()
	for item in contents:
		var item_inst = storage_list_item.instantiate()
		item_inst.entity = item
		item_inst.add_to_inv.connect(storage_item_clicked)
		list.add_child(item_inst)
		list.get_child(0).grab_focus()
	
