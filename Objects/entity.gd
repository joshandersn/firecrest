extends Node2D

@export var entity: ResEntity
@export var is_player := false
@export var player_index := 0

@onready var move = $Move

var rng = RandomNumberGenerator.new()

func refresh() -> void:
	$Label.visible = is_player
	if entity:
		$Sprite.texture = entity.artwork
		
func take_turn():
	if !is_player and entity.inititive > 0:
		var r = rng.randf_range(0, 1)
		if r > 0.75:
			move.use(Vector2.UP)
		elif r > 0.5:
			move.use(Vector2.DOWN)
		elif r > 0.25:
			move.use(Vector2.LEFT)
		else:
			move.use(Vector2.RIGHT)

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


func _on_mouse_entered() -> void:
	Game.ui_inspect_entity_description = str(entity.tag)
	Game.emit_signal("ui_update")
