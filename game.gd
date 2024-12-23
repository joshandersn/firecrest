extends Node

# Config
var tile_res := Vector2(15,20)
var players: Array[Node2D]
var real_time := false

var opened_storage_contents: Array[ResEntity]
var opened_storage_containers: Array[Node2D]
var ui_inspect_tile_title: String
var ui_inspect_tile_description: String
var ui_inspect_entity_title: String
var ui_inspect_entity_description: String
var current_focused_entity: Node2D

signal ui_update
signal center_camera
signal game_log
signal advance_turn

#func satisfy_signals() -> void:
	#emit_signal("advance_turn")
	#emit_signal("ui_update")
	#emit_signal("game_log", "hello world")
	#emit_signal("center_camera")
