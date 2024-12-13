extends Node

# Config
var tile_res := Vector2(15,20)
var players: Array[Node2D]

var opened_storage_contents: Array[ResEntity]
var opened_storage_containers: Array[Node2D]
var ui_inspect_tile_title: String
var ui_inspect_tile_description: String
var ui_inspect_entity_title: String
var ui_inspect_entity_description: String
signal ui_update
signal center_camera
