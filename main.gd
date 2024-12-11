extends Node2D

@onready var tile = load("res://Entities/tile.tscn")
@onready var sand = load("res://Tiles/sand.tres")
@export var tile_res := Vector2(20,30)

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
			new_tile.position.x = b*tile_res.x
			new_tile.position.y = a*tile_res.y
			new_tile.tile.tag = str('tile x:', b, ' y:', a)
			$Scene.add_child(new_tile)

func _ready() -> void:
	generate_map(10,5)
	update_world()
