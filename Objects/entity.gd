extends Node2D

@export var entity: ResEntity
@export var is_player := false
@export var player_index := 0

var detected_entities: Array[Node2D]

@onready var move = $Move

var rng = RandomNumberGenerator.new()

func refresh() -> void:
	$Label.visible = is_player
	if entity:
		if entity.health <= 0:
			$Sprite.texture = entity.artwork_dead
		else:
			$Sprite.texture = entity.artwork


func move_randomly() -> void:
	var r = rng.randf_range(0, 1)
	if r > 0.75:
		move.use(Vector2.UP)
	elif r > 0.5:
		move.use(Vector2.DOWN)
	elif r > 0.25:
		move.use(Vector2.LEFT)
	else:
		move.use(Vector2.RIGHT)

var parallel_modal := false
func move_toward_direction(target) -> void:
	# TODO: Figure out non-diagnol movement perhaps separate x and y with with rng
	if parallel_modal:
		if target.position.x > position.x:
			move.use(Vector2.RIGHT)
		else:
			move.use(Vector2.LEFT)
		parallel_modal = false
	else:
		if target.position.y < position.y:
			move.use(Vector2.UP)
		else:
			move.use(Vector2.DOWN)
		parallel_modal = true

func awareness_check() -> void:
	pass
	
func take_turn():
	if !is_player and entity.inititive > 0 and entity.health > 0:
		if entity.savagery > 5:
			# TODO: The enity will find a target and hunt it down
			var target = Game.players[0]
			awareness_check()
			if target.entity.health > 0:
				move_toward_direction(target)
		else:
			move_randomly()

func _input(_event: InputEvent) -> void:
	if is_player and entity.health > 0:
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
