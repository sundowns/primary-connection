extends Marker3D

var target_scene: PackedScene = preload("res://components/target.tscn")

func spawn() -> void:
	var colour := SpawnManager.get_colour_for_new_spawn()
	var new_target: Target = target_scene.instantiate()
	new_target.colour = colour
	add_sibling(new_target)
	new_target.position += Vector3(randf_range(-2.5, 2.5), randf_range(-0.75, 1.5), randf_range(3, 8))
