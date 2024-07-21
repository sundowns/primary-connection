extends Node

signal life_lost()
signal game_over

const starting_lives: int = 3
var current_lives: float = 0

var targets_destroyed: int = 0
var time_elapsed: float = 0.0
var is_running: bool = false

func _ready() -> void:
	set_process(false)

func start_game() -> void:
	current_lives = starting_lives
	time_elapsed = 0.0
	targets_destroyed = 0
	is_running = true
	set_process(true)

func _process(delta: float) -> void:
	if is_running:
		time_elapsed += delta

func _on_target_self_destruct() -> void:
	if not is_running:
		return
	current_lives -= 1
	life_lost.emit()
	if current_lives <= 0:
		game_over.emit()
		is_running = false
