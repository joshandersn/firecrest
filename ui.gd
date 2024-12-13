extends CanvasLayer

@onready var inv_list_item = load("res://Objects/inventoryListItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.ui_update.connect(update_ui)

func update_ui() -> void:
	$HUD/EntityInspect.text = str(Game.ui_inspect_entity_description)
	$HUD/TileInspect.text = str(Game.ui_inspect_tile_description)
	for leftover in $HUD/OpenedStorageList.get_children():
		leftover.queue_free()
	for item in Game.opened_storage_contents:
		var item_inst = inv_list_item.instantiate()
		item_inst.entity = item
		$HUD/OpenedStorageList.add_child(item_inst)
		$HUD/OpenedStorageList.get_child(0).grab_focus()
	
	$HUD/InvBG.visible = !(Game.opened_storage_contents == [])
