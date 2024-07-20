extends Control
class_name ColourControlNode

@export var outline_image: Texture2D = preload("res://assets/keyboard_q_outline.svg")
@export var filled_image: Texture2D = preload("res://assets/keyboard_q.svg")
@export var colour: Color = Color.RED
@export var is_enabled: bool = false:
	set(value):
		update_enabled_status(value)

@onready var enabled_ui: Control = $Enabled
@onready var enabled_texture_rect: TextureRect = $Enabled/TextureRect
@onready var disabled_ui: Control = $Disabled
@onready var disabled_texture_rect: TextureRect = $Disabled/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	disabled_texture_rect.texture = outline_image
	enabled_texture_rect.texture = filled_image
	update_enabled_status(is_enabled)

func update_enabled_status(new_value: bool) -> void:
	if enabled_ui:
		enabled_ui.visible = new_value
	if disabled_ui:
		disabled_ui.visible = not new_value

func toggle() -> void:
	is_enabled = not is_enabled
