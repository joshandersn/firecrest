extends Resource

class_name ResEntity

@export var tag: String
@export var artwork: Texture
@export var artwork_dead := preload("res://Assets/grave.png")
@export var portrait: Texture

@export var health: int
@export var health_max: int
@export var strength: int
@export var inititive: int
@export var mass: int
@export var sharpness: int
@export var protein: int
@export var savagery: int
@export var sense: int

@export var wielded: ResEntity
@export var storage: Array[ResEntity]
