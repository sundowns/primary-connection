extends CharacterBody3D
class_name Target

@export var colour: Color = Color.RED
@onready var mesh: MeshInstance3D = $targetA2/targetA

func _ready() -> void:
	update_mesh()

func update_mesh() -> void:
	mesh.set_surface_override_material(0, ColourManager.get_material(colour))
