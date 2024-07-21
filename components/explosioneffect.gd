extends Node3D
class_name ExplosionEffect

var colour: ColourManager.ColourOption = ColourManager.ColourOption.RED

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D

func _ready() -> void:
	animated_sprite.modulate = ColourManager.colours[colour]

func set_colour(val: ColourManager.ColourOption) -> void:
	colour = val

func _on_animated_sprite_3d_animation_finished():
	await get_tree().create_timer(0.3)
	queue_free()
