extends Node

@onready var parent = get_parent()

var detected_bodies: Array[Node2D]
@onready var sense_box = $"../Sense/Hitbox"

func update() -> void:
	sense_box.shape = RectangleShape2D.new()
	sense_box.shape.size = Game.tile_res * parent.entity.sense

func _ready() -> void:
	update()
	
func use():
	update()
	return detected_bodies
	
func clear_sensory() -> void:
	detected_bodies.resize(0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	detected_bodies.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	detected_bodies.erase(area)
