extends Node3D
class_name ExplosionEffect

var colour: ColourManager.ColourOption = ColourManager.ColourOption.RED

@onready var animated_sprite: AnimatedSprite3D = $AnimatedSprite3D

@onready var particles: GPUParticles3D = $GPUParticles3D

func _ready() -> void:
	animated_sprite.modulate = ColourManager.colours[colour]
	particles.material_override = ColourManager.materials[colour]
	await get_tree().create_timer(0.15).timeout
	particles.emitting = true

func set_colour(val: ColourManager.ColourOption) -> void:
	colour = val

func _on_animated_sprite_3d_animation_finished():
	await get_tree().create_timer(0.2).timeout
	animated_sprite.visible = false
	await get_tree().create_timer(0.6).timeout
	queue_free()
