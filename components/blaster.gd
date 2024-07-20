extends Node3D
class_name Blaster

@onready var mesh: MeshInstance3D = $blasterG

func set_colour(colour: Color) -> void:
	var material: BaseMaterial3D = mesh.get_surface_override_material(3)
	material.albedo_color = colour
