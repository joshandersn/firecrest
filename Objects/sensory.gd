extends Node

@onready var parent = get_parent()

var sensory_instances: Array[Area2D]
var offset = Vector2(8,10)
var detected_bodies: Array[Node2D]

func use() -> void:
	pass

func get_bodies():
	return detected_bodies
	
func clear_sensory() -> void:
	detected_bodies.resize(0)

func _on_area_2d_area_entered(area: Area2D) -> void:
	detected_bodies.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	detected_bodies.erase(area)
