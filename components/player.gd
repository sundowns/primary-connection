extends Node3D
class_name Player

const FIRE_RAY_LENGTH: float = 1000

@export_flags_3d_physics var collision_mask: int = 1

@onready var camera: Camera3D = $Camera3D

func fire_at_point_on_screen(screen_position: Vector2) -> void:
	var from: Vector3 = camera.project_ray_origin(screen_position)
	var to: Vector3 = from + camera.project_ray_normal(screen_position) * FIRE_RAY_LENGTH
	var raycast_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(create_raycast_collision_query(from, to))
	if raycast_result:
		var collider = raycast_result['collider']
		if collider is Target:
			collider._on_hit()

func create_raycast_collision_query(from: Vector3, to: Vector3) -> PhysicsRayQueryParameters3D:
	var ray_query := PhysicsRayQueryParameters3D.new()
	ray_query.from = from
	ray_query.to = to
	ray_query.collision_mask = collision_mask
	return ray_query
