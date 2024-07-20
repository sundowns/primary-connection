extends Node3D
class_name Blaster

@onready var mesh: MeshInstance3D = $blasterG
@onready var muzzle: Marker3D = $Muzzle

@export var beam_instance_scene: PackedScene = preload("res://components/beam_instance.tscn")

func set_colour(colour: Color) -> void:
	var material: BaseMaterial3D = mesh.get_surface_override_material(3)
	material.albedo_color = colour

func create_beam(endpoint: Vector3, colour: ColourManager.ColourOption):
	var effects_node = DependencyHelper.retrieve("Effects")
	var new_beam: BeamInstance = beam_instance_scene.instantiate()
	new_beam.set_colour(colour)
	effects_node.add_child(new_beam)
	new_beam.global_transform.origin = muzzle.global_position
	new_beam.extend_to(endpoint)
