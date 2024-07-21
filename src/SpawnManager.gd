extends Node

var spawners: Array[TargetSpawner] = []

var spawn_timer: Timer
var initial_spawn_interval: float = 2.0
var current_spawn_interval: float = initial_spawn_interval
var minimum_spawn_interval: float = 0.1
# TODO: a curve would go crazy here

# How many targets to spawn at once
var initial_spawn_count: int = 1
var minimum_spawn_count: int = 1
var maximum_spawn_count: int = 1 # this should probably just be the number of paths?
# TODO: some kind of acceleration curve with time, idk u figure it out nerd

func start_game() -> void:
	targets_spawned = 0
	spawn_timer = Timer.new()
	spawn_timer.one_shot = true
	spawn_timer.autostart = false
	add_child(spawn_timer)
	spawn_timer.timeout.connect(self._on_spawn_timer_timeout)
	spawn_timer.start(current_spawn_interval)

var targets_spawned: int = 0

func get_colour_for_new_spawn() -> ColourManager.ColourOption:
	if targets_spawned <= 10:
		return ColourManager.get_random_primary_colour()
	elif targets_spawned <= 30:
		return ColourManager.get_random_primary_or_secondary_colour()
	else:
		return ColourManager.get_random_colour()

func register_spawner(new_spawner: TargetSpawner) -> void:
	spawners.push_back(new_spawner) 

func _on_spawn_timer_timeout() -> void:
	var spawner_indices_used: Array[int] = []
	for i in range(decide_number_to_spawn()):
		var spawner_index: int = randi_range(0, spawners.size()-1)
		var attempts: int = 1
		var max_attempts: int = 8
		while spawner_indices_used.has(spawner_index) and attempts < max_attempts:
			spawner_index = randi_range(0, spawners.size()-1)
			attempts += 1
		if attempts >= max_attempts:
			continue
		var spawner: TargetSpawner = spawners[spawner_index]
		spawner_indices_used.push_back(spawner_index)
		if spawner and is_instance_valid(spawner):
			spawner.spawn()
	spawn_timer.start(current_spawn_interval)

func decide_number_to_spawn() -> int:
	return randi_range(minimum_spawn_count, maximum_spawn_count)
