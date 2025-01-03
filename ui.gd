extends CanvasLayer

@onready var storage_list_item = load("res://Objects/inventoryListItem.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.ui_update.connect(update_ui)
	Game.game_log.connect(game_log)
	Game.start_conversation.connect(update_dialog_ui)

func update_dialog_ui(player, conversant, content) -> void:
	$HUD/Dialog.visible = true
	$HUD/Dialog/DialogPortrait.texture = conversant.entity.portrait
	$HUD/Dialog/DialogContent.text = content
	Game.center_camera.emit(conversant)
	
func toggle_inventory_view() -> void:
	$HUD/PlayerInvBG.visible = !$HUD/PlayerInvBG.visible
	update_ui()

func remove_item(origin, item) -> void:
	if origin == $HUD/PlayerInvBG/ScrollContainer/PlayerStorageList:
		Game.players[0].entity.storage.erase(item)
	else:
		if Game.opened_storage_containers:
			if is_instance_valid(Game.opened_storage_containers[0]):
				Game.opened_storage_containers[0].entity.storage.erase(item)
				Game.opened_storage_contents.erase(item)
		else:
			push_warning("There is no shared world containers!")
	update_ui()

func storage_item_clicked(origin, item) -> void:
	if !origin == $HUD/PlayerInvBG/ScrollContainer/PlayerStorageList:
		Game.players[0].entity.storage.append(item)
		remove_item(origin, item)
	else:
		print("Item is in inventory: skipped looting")
	update_ui()

func equip_item(origin, item) -> void:
	if !origin == $HUD/PlayerInvBG/ScrollContainer/PlayerStorageList:
		storage_item_clicked(origin, item)
	if item.mass < Game.players[0].entity.strength:
		if origin == $HUD/PlayerInvBG/ScrollContainer/PlayerStorageList:
			remove_item(origin, item)
			if Game.players[0].entity.wielded:
				Game.players[0].entity.storage.append(Game.players[0].entity.wielded)
			Game.players[0].entity.wielded = item
	else:
		Game.emit_signal("game_log", str(item.tag, " is too heavy (", item.mass, ") to equip."))
	update_ui()

func eat_item(origin, item) -> void:
	var player = Game.players[0].entity
	if item.mass < player.strength:
		if player.health >= player.health_max:
			player.health = player.health_max
			player.mass += ((player.health + item.protein) - player.health_max) / 2
			player.protein += item.protein
			Game.emit_signal("game_log", str("[color=green]", player.tag, "[/color] stomache is full, eating that [color=green]", item.tag, "[/color] put on some wieght!."))
		else:
			player.health += item.protein
			if player.health >= player.health_max:
				player.health = player.health_max
			Game.emit_signal("game_log", str("[color=green]", player.tag, "[/color] consumed ", item.tag, " for [color=blue]", item.protein, "[/color] health."))
		remove_item(origin, item)
	else:
		Game.emit_signal("game_log", str("[color=green]", item.tag, "[/color] was unable to fit in [color=green]", player.tag, "'s[/color] mouth."))
		
	

func game_log(message) -> void:
	#$HUD/Log.text += str("\n", message)
	$HUD/Log.append_text(str("\n", message))

func format_entity_stats(player: ResEntity):
	var string := ""
	var p = [
		['Health', player.health],
		['Mass', player.mass],
		['Strength', player.strength],
		['Sharpness', player.sharpness],
		['Inititive', player.inititive],
	]
	for stat in p:
		string += str(stat[0], ": ", stat[1], "\n")
	return string

func update_ui() -> void:
	$HUD/EntityInspect.text = str(Game.ui_inspect_entity_description)
	$HUD/TileInspect.text = str(Game.ui_inspect_tile_description)
	$HUD/Paused.visible = !Game.real_time
	update_storage_list($HUD/StorageBG/OpenedStorageList, Game.opened_storage_contents)
	if Game.players.size() > 0 and is_instance_valid(Game.players[0]):
		var player = Game.players[0].entity
		$HUD/PlayerInvBG/PlayerPortrait.texture = player.portrait
		$HUD/PlayerPortrait.texture = player.portrait
		if player.wielded:
			$HUD/PlayerInvBG/PlayerWielded.texture = player.wielded.artwork
			$HUD/PlayerWield.texture = player.wielded.artwork
		$HUD/PlayerInvBG/PlayerTags.text = format_entity_stats(player)
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
		item_inst.eat_item.connect(eat_item)
		list.add_child(item_inst)
		list.get_child(0).grab_focus()
	


func _on_exit_pressed() -> void:
	$HUD/Dialog.visible = false
