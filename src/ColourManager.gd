extends Node

# TODO: Probably replace these with less offensive versions of each (i.e. not maxed out rgb vals)
var colours: Array[Color] = [
	# single colours
	Color.RED, 
	Color.BLUE,
	Color.GREEN,
	# combos of two
	Color.MAGENTA,
	Color.YELLOW,
	Color.CYAN,
	# Three
	Color.WHITE,
	# None
	Color.BLACK
]

var base_material: BaseMaterial3D = preload("res://materials/base_target_colour.tres")
var materials: Dictionary = {}

func _ready():
	generate_materials()

func generate_materials() -> void:
	for colour in colours:
		var coloured_material: BaseMaterial3D = base_material.duplicate()
		coloured_material.albedo_color = colour
		materials[colour] = coloured_material

func get_material(colour: Color) -> BaseMaterial3D:
	if materials.has(colour):
		return materials[colour]
	else:
		push_error("Attempted to fetch material for unregistered colour: ", colour)
		return base_material
