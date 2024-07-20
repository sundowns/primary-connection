extends CharacterBody3D
class_name Target

@export var colour: ColourManager.ColourOption
@onready var mesh: MeshInstance3D = $targetA2/targetA

func _ready() -> void:
	update_mesh()

func update_mesh() -> void:
	mesh.set_surface_override_material(0, ColourManager.get_material(colour))

func _on_hit(attack_colour: ColourManager.ColourOption) -> void:
	if attack_colour == colour:
		handle_correct_colour_hit()
	else:
		handle_wrong_colour_hit()

func handle_correct_colour_hit() -> void:
	queue_free()

func handle_wrong_colour_hit() -> void:
	print('wrong colour idiot...')
