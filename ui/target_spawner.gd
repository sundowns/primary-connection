extends Marker3D
class_name TargetSpawner

var target_scene: PackedScene = preload("res://components/target.tscn")
var target_follower_scene: PackedScene = preload("res://components/target_path_follower.tscn")

func spawn() -> void:
	# Create the target and add it to our scene, under the target_anchor
	var colour := SpawnManager.get_colour_for_new_spawn()
	var new_target: Target = target_scene.instantiate()
	new_target.colour = colour
	var target_anchor: Node3D = DependencyHelper.retrieve("Targets")
	target_anchor.add_child(new_target)
	
	#Create a follower node as a sibling, which will project its transform onto the target
	var follower: TargetPathFollower = target_follower_scene.instantiate()
	follower.set_target(new_target)
	add_sibling(follower)
	#add_sibling(new_target)
	#new_target.global_position. 
