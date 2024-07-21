extends CharacterBody3D
class_name Target

signal destroyed

@export var colour: ColourManager.ColourOption
@onready var mesh: MeshInstance3D = $targetA2/targetA
@onready var collision_shape: CollisionShape3D = $CollisionShape3D
@onready var shatter_particles: GPUParticles3D = $ShatterParticles
@onready var smoke_particles: GPUParticles3D = $SmokeParticles
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var explosion_effect_scene: PackedScene = preload("res://components/explosioneffect.tscn")

@onready var begin_expiry_timer: Timer = $BeginExpiryTimer

var is_starter_target: bool = false
var in_move_to_target_mode: bool = false
var speed: float = 1.0
var minimum_distance_to_player: float = 2.0

func _ready() -> void:
	update_meshes()
	smoke_particles.emitting = false
	if is_starter_target:
		begin_expiry_timer.queue_free()
	else:
		SpawnManager.targets_spawned += 1

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
	LifeManager.targets_destroyed += 1
	queue_free()

func handle_wrong_colour_hit() -> void:
	pass

func _process(delta: float):
	if in_move_to_target_mode:
		var to_player: Vector3 = DependencyHelper.retrieve("Player").global_position - global_position
		if to_player.length() < minimum_distance_to_player:
			set_process(false)
			return
		var direction := to_player.normalized()
		global_position += direction * speed * delta

func set_as_starter_target() -> void:
	is_starter_target = true

func _on_begin_expiry_timer_timeout():
	animation_player.play("Expire")

func _on_expiry_animation_ended() -> void:
	var explosion_effect: ExplosionEffect = explosion_effect_scene.instantiate()
	explosion_effect.set_colour(colour)
	DependencyHelper.retrieve("Effects").add_child(explosion_effect)
	explosion_effect.global_position = global_position
	destroyed.emit()
	LifeManager._on_target_self_destruct()
	queue_free()

func switch_to_move_towards_player(new_speed: float) -> void:
	in_move_to_target_mode = true
	speed = new_speed
	set_process(true)
