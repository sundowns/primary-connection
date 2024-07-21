extends TextureRect
class_name HealthIcon

@onready var broken_icon = preload("res://assets/suit_hearts_broken.svg")

@export var healthy_colour: Color = Color("#ff8a8a")
@export var broken_colour: Color = Color("#636363")

var is_broken: bool = false

func _ready():
	self_modulate = healthy_colour

func go_broken_style_jutsu() -> void:
	is_broken = true
	self_modulate = broken_colour
	texture = broken_icon
