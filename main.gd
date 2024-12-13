extends Node2D

@onready var tile = load("res://Objects/tile.tscn")
@onready var entity = load("res://Objects/entity.tscn")

@onready var stone = load("res://Tiles/Stone.tres")
@onready var stone_wall = load("res://Tiles/StoneWall.tres")

@onready var chest = load("res://Entities/Chest.tres")
@onready var slime = load("res://Entities/Slime.tres")
@onready var knight = load("res://Entities/knight.tres")

var rng = RandomNumberGenerator.new()

func _input(_event: InputEvent) -> void:
	#debug to update world
	if Input.is_action_just_pressed("ui_accept"):
		#update_world()
		pass

func update_world() -> void:
	var count = 0
	for i in $Scene.get_children():
		if i.is_in_group("entity") and !i.is_player:
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
			print(new_tile)
			$Scene.add_child(new_tile)
			
func populate_map() -> void:
	for object in $Scene.get_children():
		if object.is_in_group("tile") and "tile" in object and !object.tile.is_wall:
			var r = rng.randf_range(0,1)
			if r > 0.9:
				var n = rng.randf_range(0, 1)
				var new_entity = entity.instantiate()
				if n > 0.9:
					new_entity.entity = chest
				else:
					new_entity.entity = slime
				new_entity.position = object.position
				new_entity.refresh()
				$Scene.add_child(new_entity)
				
func spawn_player() -> void:
	for object in $Scene.get_children():
		if object.is_in_group("tile") and "tile" in object and !object.tile.is_wall:
			var r = rng.randf_range(0,1)
			var new_player = entity.instantiate()
			if r > 0.9:
				new_player.position = object.position
				new_player.is_player = true
				new_player.entity = knight
				new_player.refresh()
				center_selection(new_player)
				$Scene.add_child(new_player)
				break

func center_selection(selection) -> void:
	$Camera2D.global_position = selection.global_position

func _ready() -> void:
	generate_map(10,5)
	populate_map()
	spawn_player()

func _on_world_tick_timeout() -> void:
	update_world()
