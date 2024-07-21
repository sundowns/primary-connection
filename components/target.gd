extends CharacterBody3D
class_name Target

signal destroyed

@export var colour: ColourManager.ColourOption
@onready var mesh: MeshInstance3D = $targetA2/targetA
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var shatter_particles: GPUParticles3D = $ShatterParticles
@onready var smoke_particles: GPUParticles3D = $SmokeParticles
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var begin_expiry_timer: Timer = $BeginExpiryTimer

var is_starter_target: bool = false

func _ready() -> void:
	update_meshes()
	smoke_particles.emitting = false
	if is_starter_target:
		begin_expiry_timer.queue_free()

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
	remove_child(shatter_particles)
	var effects_node = DependencyHelper.retrieve("Effects")
	effects_node.add_child(shatter_particles)
	shatter_particles.global_position = global_position
	shatter_particles.emitting = true
	destroyed.emit()
	queue_free()

func handle_wrong_colour_hit() -> void:
	pass

func set_as_starter_target() -> void:
	is_starter_target = true

func _on_begin_expiry_timer_timeout():
	animation_player.play("Expire")

func _on_expiry_animation_ended() -> void:
	LifeManager._on_target_self_destruct()
	queue_free()
