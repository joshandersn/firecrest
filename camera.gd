extends Camera2D

func _process(_delta: float) -> void:
	if Input.get_axis("ui_down", "ui_up"):
		position.y += Input.get_axis("ui_up", "ui_down")
	if Input.get_axis("ui_left", "ui_right"):
		position.x += Input.get_axis("ui_left", "ui_right")

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("zoom_out"):
		zoom -= Vector2(1,1)
	if Input.is_action_just_pressed("zoom_in"):
		zoom += Vector2(1,1)
