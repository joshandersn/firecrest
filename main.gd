extends Node2D

@onready var tile = load("res://Objects/tile.tscn")
@onready var sand = load("res://Tiles/Stone.tres")

func _input(_event: InputEvent) -> void:
	#debug to update world
	if Input.is_action_just_pressed("ui_accept"):
		update_world()

func update_world() -> void:
	for i in $Scene.get_children():
		if i.is_in_group("tile"):
			i.refresh()

func generate_map(x, y) -> void:
	for a in y:
		for b in x:
			var new_tile = tile.instantiate()
			new_tile.tile = sand
			new_tile.position.x = b*Game.tile_res.x
			new_tile.position.y = a*Game.tile_res.y
			new_tile.tile.tag = str('tile x:', b, ' y:', a)
			print(new_tile)
			$Scene.add_child(new_tile)

func _ready() -> void:
	generate_map(10,5)
	update_world()
