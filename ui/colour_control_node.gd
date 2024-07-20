extends Control
class_name ColourControlNode

@export var outline_image: Texture2D = preload("res://assets/keyboard_a_outline.svg")
@export var filled_image: Texture2D = preload("res://assets/keyboard_a.svg")
@export var enabled_colour: Color = ColourManager.colours[ColourManager.ColourOption.RED]
@export var disabled_colour: Color = Color.DIM_GRAY
@export var is_enabled: bool = false

@onready var enabled_ui: Control = $Enabled
@onready var enabled_texture_rect: TextureRect = $Enabled/TextureRect
@onready var disabled_ui: Control = $Disabled
@onready var disabled_texture_rect: TextureRect = $Disabled/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready():
	disabled_texture_rect.texture = outline_image
	disabled_texture_rect.self_modulate = disabled_colour
	enabled_texture_rect.texture = filled_image
	enabled_texture_rect.self_modulate = enabled_colour
	update_enabled_status(is_enabled)

func update_enabled_status(new_value: bool) -> void:
	if enabled_ui:
		enabled_ui.visible = new_value
	if disabled_ui:
		disabled_ui.visible = not new_value

func toggle() -> void:
	is_enabled = not is_enabled
	update_enabled_status(is_enabled)
