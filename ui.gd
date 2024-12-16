extends CanvasLayer

@onready var storage_list_item = load("res://Objects/inventoryListItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.ui_update.connect(update_ui)
	Game.game_log.connect(game_log)

func toggle_inventory_view() -> void:
	$HUD/PlayerInvBG.visible = !$HUD/PlayerInvBG.visible
	update_ui()

func storage_item_clicked(origin, item) -> void:
	if !origin == $HUD/PlayerInvBG/ScrollContainer/PlayerStorageList:
		Game.players[0].entity.storage.append(item)
		if Game.opened_storage_containers:
			Game.opened_storage_containers[0].entity.storage.erase(item)
			Game.opened_storage_contents.erase(item)
		else:
			push_warning("There is no shared world containers!")
	else:
		print("Item is in inventory: skipped looting")
	update_ui()

func equip_item(origin, item) -> void:
	if !origin == $HUD/PlayerInvBG/ScrollContainer/PlayerStorageList:
		storage_item_clicked(origin, item)
	if item.mass < Game.players[0].entity.strength:
		Game.players[0].entity.wielded = item
	else:
		print(item.mass, " is too heavy for your strength (", Game.players[0].entity.strength, ")")
	update_ui()

func game_log(message):
	$HUD/Log.text += str("\n", message)

func update_ui() -> void:
	$HUD/EntityInspect.text = str(Game.ui_inspect_entity_description)
	$HUD/TileInspect.text = str(Game.ui_inspect_tile_description)
	update_storage_list($HUD/OpenedStorageList, Game.opened_storage_contents)
	if Game.players:
		var player = Game.players[0].entity
		var player_stats = str(player.tag, player.health, player.strength, player.inititive, player.wielded)
		$HUD/PlayerInvBG/PlayerPortrait.texture = player.portrait
		$HUD/PlayerPortrait.texture = player.portrait
		if player.wielded:
			$HUD/PlayerInvBG/PlayerWielded.texture = player.wielded.artwork
			$HUD/PlayerWield.texture = player.wielded.artwork
		$HUD/PlayerInvBG/PlayerTags.text = player_stats
		update_storage_list($HUD/PlayerInvBG/ScrollContainer/PlayerStorageList, player.storage)
	$HUD/StorageBG.visible = !(Game.opened_storage_contents == [])

func update_storage_list(list, contents) -> void:
	for leftover in list.get_children():
		leftover.queue_free()
	for item in contents:
		var item_inst = storage_list_item.instantiate()
		item_inst.entity = item
		item_inst.origin = list
		item_inst.add_to_inv.connect(storage_item_clicked)
		item_inst.equip_item.connect(equip_item)
		list.add_child(item_inst)
		list.get_child(0).grab_focus()
	
