extends Node

var spawners: Array[TargetSpawner] = []

var spawn_timer: Timer
var initial_spawn_interval: float = 4.0
var current_spawn_interval: float = initial_spawn_interval
var minimum_spawn_interval: float = 0.5
var spawn_interval_curve: Curve = preload("res://components/spawn_interval_curve.tres")

# How many targets to spawn at once
var initial_spawn_count: int = 1
var current_minimum_spawn_count: int = 1
var current_maximum_spawn_count: int = 1
var maximum_spawn_count: int = 5

var maximum_time_for_scaling: float = 60 * 5 # seconds

func _ready():
	set_process(false)

func start_game() -> void:
	targets_spawned = 0
	spawn_timer = Timer.new()
	spawn_timer.one_shot = true
	spawn_timer.autostart = false
	add_child(spawn_timer)
	spawn_timer.timeout.connect(self._on_spawn_timer_timeout)
	spawn_timer.start(0.5)
	set_process(true)

var targets_spawned: int = 0

func get_colour_for_new_spawn() -> ColourManager.ColourOption:
	if targets_spawned <= 6:
		return ColourManager.get_random_primary_colour()
	elif targets_spawned <= 20:
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
	return randi_range(current_minimum_spawn_count, current_maximum_spawn_count)

func update_spawn_interval(elapsed: float) -> void:
	var difficulty_rating: float = minf(elapsed/maximum_time_for_scaling, 1.0) # % of total scaling (between 0 and 1)
	var sample: float = 1.0 - spawn_interval_curve.sample(difficulty_rating)
	var new_interval := initial_spawn_interval - (sample * initial_spawn_interval)
	current_spawn_interval = maxf(new_interval, minimum_spawn_interval)

func update_spawn_count(elapsed: float) -> void:
	if elapsed > 45:
		current_maximum_spawn_count = 2
	if elapsed > 250:
		current_maximum_spawn_count = 3
	if elapsed > 600:
		current_maximum_spawn_count = 4
	
	if elapsed > 90:
		current_minimum_spawn_count = 2
	if elapsed > 400:
		current_minimum_spawn_count = 3
	if elapsed > 500:
		current_minimum_spawn_count = 4

func _process(_delta: float) -> void:
	update_spawn_interval(LifeManager.time_elapsed)
	update_spawn_count(LifeManager.time_elapsed)
	
