extends Node2D

@export var entity: ResEntity
@export var is_player := false
@export var player_index := 0

@onready var move = $Move

func refresh() -> void:
	$Label.visible = is_player
	if entity:
		$Sprite.texture = entity.artwork

func _input(_event: InputEvent) -> void:
	if is_player:
		if Input.is_action_just_pressed("move_up"):
			move.use(Vector2.UP)
		elif Input.is_action_just_pressed("move_down"):
			move.use(Vector2.DOWN)
		elif Input.is_action_just_pressed("move_left"):
			move.use(Vector2.LEFT)
		elif Input.is_action_just_pressed("move_right"):
			move.use(Vector2.RIGHT)
