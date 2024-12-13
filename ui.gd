extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Game.ui_update.connect(update_ui)

func update_ui() -> void:
	$HUD/EntityInspect.text = str(Game.ui_inspect_entity_description)
	$HUD/TileInspect.text = str(Game.ui_inspect_tile_description)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
