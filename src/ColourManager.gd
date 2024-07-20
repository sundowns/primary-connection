extends Node

signal active_colour_changed(colour: ColourOption)
var active_colour: ColourOption

enum ColourOption {
	RED,
	GREEN,
	BLUE,
	PURPLE,
	YELLOW,
	CYAN,
	WHITE,
	BLACK,
}

var colours: Dictionary = {
	# single colours
	ColourOption.RED: Color("#ff4040"),
	ColourOption.GREEN: Color("#40ff40"),
	ColourOption.BLUE: Color("#4076ff"),
	# combos of two
	ColourOption.PURPLE: Color.PURPLE,
	ColourOption.YELLOW: Color.GOLD,
	ColourOption.CYAN: Color.TURQUOISE,
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
func colour_changed(red_enabled: bool, green_enabled: bool, blue_enabled: bool) -> void:
	if red_enabled:
		if green_enabled and blue_enabled:
			# all 3, white
			set_active_colour(ColourOption.WHITE)
		elif green_enabled:
			# red + green = yellow
			set_active_colour(ColourOption.YELLOW)
		elif blue_enabled:
			# red + blue = purple
			set_active_colour(ColourOption.PURPLE)
		else:
			# just red
			set_active_colour(ColourOption.RED)
	elif green_enabled:
		if blue_enabled:
			# green + blue = cyan
			set_active_colour(ColourOption.CYAN)
		else:
			# just green
			set_active_colour(ColourOption.GREEN)
	elif blue_enabled:
		set_active_colour(ColourOption.BLUE)
	else:
		set_active_colour(ColourOption.BLACK)

func get_random_colour() -> ColourOption:
	var all_options: Array = colours.keys()
	return all_options[randi_range(0, all_options.size()-1)]
