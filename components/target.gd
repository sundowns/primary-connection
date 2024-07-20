extends CharacterBody3D
class_name Target

@export var colour: ColourManager.ColourOption
@onready var mesh: MeshInstance3D = $targetA2/targetA
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var shatter_particles: GPUParticles3D = $ShatterParticles

func _ready() -> void:
	update_meshes()

func update_meshes() -> void:
	var actual_colour := ColourManager.get_material(colour)
	mesh.set_surface_override_material(0, actual_colour)
	shatter_particles.material_override = actual_colour

func _on_hit(attack_colour: ColourManager.ColourOption) -> void:
	if attack_colour == colour:
		handle_correct_colour_hit()
	else:
		handle_wrong_colour_hit()

func handle_correct_colour_hit() -> void:
	mesh.visible = false
	shatter_particles.emitting = true
	collision_shape.disabled = false
	await shatter_particles.finished
	queue_free()

func handle_wrong_colour_hit() -> void:
	print('wrong colour idiot...')
