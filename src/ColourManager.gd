extends Node

signal active_colour_changed(colour: ColourOption)
var active_colour: ColourOption

enum ColourOption {
	RED,
	YELLOW,
	BLUE,
	PURPLE,
	GREEN,
	ORANGE,
	WHITE,
	BLACK,
}

var colours: Dictionary = {
	# single colours
	ColourOption.RED: Color("#ff4040"),
	ColourOption.YELLOW: Color("#ffff14"),
	ColourOption.BLUE: Color("#4076ff"),
	# combos of two
	ColourOption.PURPLE: Color.PURPLE,
	ColourOption.GREEN: Color("#40ff40"),
	ColourOption.ORANGE: Color.DARK_ORANGE,
	# Three
	ColourOption.WHITE: Color.WHITE,
	# None
	ColourOption.BLACK: Color.BLACK
}

var base_material: BaseMaterial3D = preload("res://materials/base_target_colour.tres")
var materials: Dictionary = {}

func _ready():
	generate_materials()

func generate_materials() -> void:
	for colour_option in colours.keys():
		var coloured_material: BaseMaterial3D = base_material.duplicate()
		coloured_material.albedo_color = colours[colour_option]
		coloured_material.emission = colours[colour_option]
		materials[colour_option] = coloured_material

func get_material(colour: ColourOption) -> BaseMaterial3D:
	if materials.has(colour):
		return materials[colour]
	else:
		push_error("Attempted to fetch material for unregistered colour: ", colour)
		return base_material

func set_active_colour(colour: ColourOption) -> void:
	active_colour = colour
	active_colour_changed.emit(active_colour)

# what have i done.......
func colour_changed(red_enabled: bool, yellow_enabled: bool, blue_enabled: bool) -> void:
	if red_enabled:
		if yellow_enabled and blue_enabled:
			# all 3, white
			set_active_colour(ColourOption.WHITE)
		elif yellow_enabled:
			# red + yellow = orange
			set_active_colour(ColourOption.ORANGE)
		elif blue_enabled:
			# red + blue = purple
			set_active_colour(ColourOption.PURPLE)
		else:
			# just red
			set_active_colour(ColourOption.RED)
	elif yellow_enabled:
		if blue_enabled:
			# yellow + blue = green
			set_active_colour(ColourOption.GREEN)
		else:
			# just green
			set_active_colour(ColourOption.YELLOW)
	elif blue_enabled:
		set_active_colour(ColourOption.BLUE)
	else:
		set_active_colour(ColourOption.BLACK)

func get_random_colour() -> ColourOption:
	var all_options: Array = colours.keys()
	return all_options[randi_range(0, all_options.size()-1)]

func get_random_primary_colour() -> ColourOption:
	var all_options: Array = [ColourOption.RED, ColourOption.YELLOW, ColourOption.BLUE]
	return all_options[randi_range(0, all_options.size()-1)]

func get_random_primary_or_secondary_colour() -> ColourOption:
	var all_options: Array = [ColourOption.RED, ColourOption.YELLOW, ColourOption.BLUE,	ColourOption.PURPLE, ColourOption.GREEN, ColourOption.ORANGE ]
	return all_options[randi_range(0, all_options.size()-1)]
