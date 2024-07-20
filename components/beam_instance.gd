extends Node3D
class_name BeamInstance

var colour: ColourManager.ColourOption
var extended_to_position: Vector3

var expiry_time: float = .3
var fade_tween: Tween

@onready var mesh: MeshInstance3D = $foamBulletA2/foamBulletA

func _ready():
	var mesh_material: BaseMaterial3D = ColourManager.materials[colour].duplicate()
	mesh_material.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
	mesh.material_override = mesh_material
	fade_tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	fade_tween.tween_property(mesh_material, "albedo_color:a", 0, expiry_time)
	await fade_tween.finished
	queue_free()

func set_colour(new_colour: ColourManager.ColourOption) -> void:
	colour = new_colour

func extend_to(pos: Vector3):
	extended_to_position = pos
	look_at(pos, Vector3.UP)
	var distance_to = (global_position - pos).length()
	scale_object_local(Vector3(1,1, distance_to/2))

