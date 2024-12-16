extends Node2D

@onready var tile = load("res://Objects/tile.tscn")
@onready var entity = load("res://Objects/entity.tscn")

@onready var stone = load("res://Tiles/Stone.tres")
@onready var stone_wall = load("res://Tiles/StoneWall.tres")

@onready var chest = load("res://Entities/Chest.tres")
@onready var slime = load("res://Entities/Slime.tres")
@onready var knight = load("res://Entities/knight.tres")
@onready var assassin = load("res://Entities/Assassin.tres")
@onready var werewolf = load("res://Entities/Werewolf.tres")
@onready var health_potion = load("res://Entities/HealthPotion.tres")

var rng = RandomNumberGenerator.new()

func _input(_event: InputEvent) -> void:
	
	if Input.is_action_just_pressed("toggle_inventory"):
		$UI.toggle_inventory_view()

	if Input.is_action_just_pressed("ui_accept"):
		#update_world()
		pass

func update_world() -> void:
	var count = 0
	for i in $Scene.get_children():
		if i.is_in_group("entity"):
			if !i.is_player:
				if "take_turn" in i:
					count += 1
					i.take_turn()
			if "refresh" in i:
				i.refresh()
	print(count, " Objects Updated")


func generate_map(x, y) -> void:
	for a in y:
		for b in x:
			var new_tile = tile.instantiate()
			var r = rng.randf_range(0,1)
			if r > 0.1:
				new_tile.tile = stone
			else:
				new_tile.tile = stone_wall
			new_tile.position.x = b*Game.tile_res.x
			new_tile.position.y = a*Game.tile_res.y
			$Scene.add_child(new_tile)
			
func populate_map() -> void:
	for object in $Scene.get_children():
		if object.is_in_group("tile") and "tile" in object and !object.tile.is_wall:
			var r = rng.randf_range(0,1)
			if r > 0.95:
				var n = rng.randf_range(0, 1)
				var new_entity = entity.instantiate()
				var new_entity_resource: ResEntity
				if n > 0.75:
					new_entity_resource = slime
				elif n > 0.50:
					new_entity_resource = chest
				elif n > 0.25:
					new_entity_resource = werewolf
				else:
					new_entity_resource = assassin
				new_entity.entity = new_entity_resource.duplicate()
				var g = rng.randf_range(0, 1)
				if g > 0.5:
					new_entity.entity.storage.append(health_potion)
				new_entity.position = object.position
				new_entity.refresh()
				$Scene.add_child(new_entity)
				
func spawn_entity(entity_resource, make_player := false) -> void:
	for object in $Scene.get_children():
		if object.is_in_group("tile") and "tile" in object and !object.tile.is_wall:
			var r = rng.randf_range(0,1)
			var new_player = entity.instantiate()
			if r > 0.9:
				new_player.position = object.position
				new_player.is_player = make_player
				new_player.entity = entity_resource.duplicate()
				new_player.refresh()
				$Scene.add_child(new_player)
				if make_player:
					Game.players.append(new_player)
				break

func center_selection(selection) -> void:
	$Camera2D.global_position = selection.global_position

func _ready() -> void:
	generate_map(20,15)
	populate_map()
	spawn_entity(slime, true)
	spawn_entity(chest)
	Game.center_camera.connect(center_selection)

func _on_world_tick_timeout() -> void:
	update_world()
