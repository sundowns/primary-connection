extends Node

var targets_spawned: int = 0

func get_colour_for_new_spawn() -> ColourManager.ColourOption:
	if targets_spawned <= 10:
		return ColourManager.get_random_primary_colour()
	elif targets_spawned <= 30:
		return ColourManager.get_random_primary_or_secondary_colour()
	else:
		return ColourManager.get_random_colour()
