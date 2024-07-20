extends Node3D
class_name Player

@export_flags_3d_physics var target_collision_mask: int = 1
const FIRE_RAY_LENGTH: float = 1000

@export_flags_3d_physics var aiming_blaster_collision_mask: int = 2
const AIM_RAY_LENGTH: float = 10000

@onready var camera: Camera3D = $Camera3D
@onready var hand: Node3D = $Camera3D/Hand
@onready var blaster: Blaster = $Camera3D/Hand/Blaster

func _ready() -> void:
	ColourManager.active_colour_changed.connect(self._on_active_colour_changed)

func _process(delta: float) -> void:
	point_blaster_at_crosshair(delta)

func fire_at_point_on_screen(screen_position: Vector2) -> void:
	var from: Vector3 = camera.project_ray_origin(screen_position)
	var to: Vector3 = from + camera.project_ray_normal(screen_position) * FIRE_RAY_LENGTH
	var raycast_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(create_raycast_collision_query(from, to, target_collision_mask))
	if raycast_result:
		var collider = raycast_result['collider']
		if collider is Target:
			collider._on_hit(ColourManager.active_colour)

func create_raycast_collision_query(from: Vector3, to: Vector3, mask: int) -> PhysicsRayQueryParameters3D:
	var ray_query := PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collision_mask = mask
	return ray_query

func point_blaster_at_crosshair(_delta: float) -> void:
	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var from: Vector3 = camera.project_ray_origin(mouse_pos)
	var to: Vector3 = from + camera.project_ray_normal(mouse_pos) * AIM_RAY_LENGTH
	var raycast_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(create_raycast_collision_query(from, to, aiming_blaster_collision_mask))
	if raycast_result:
		hand.look_at(raycast_result['position'])

func _on_active_colour_changed(new_active_colour: Color) -> void:
	blaster.set_colour(new_active_colour)
