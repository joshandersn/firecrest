extends Node2D

@export var entity: ResEntity
@export var player_index := 0

func move_direction(dir) -> void:
	$Check.target_position = Game.tile_res * dir
	position += Game.tile_res * dir

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("move_up"):
		move_direction(Vector2.UP)
	elif Input.is_action_just_pressed("move_down"):
		move_direction(Vector2.DOWN)
	elif Input.is_action_just_pressed("move_left"):
		move_direction(Vector2.LEFT)
	elif Input.is_action_just_pressed("move_right"):
		move_direction(Vector2.RIGHT)
