extends Node

signal life_lost(lives_left: int)
signal game_over

const starting_lives: int = 3
var current_lives: float = 0

var time_elapsed: float = 0.0
var is_running: bool = false

func _ready() -> void:
	set_process(false)
	start_game() # TODO: do this elsewhere

func start_game() -> void:
	current_lives = starting_lives
	time_elapsed = 0.0
	is_running = true
	set_process(true)

func _process(delta: float) -> void:
	if is_running:
		time_elapsed += delta

func _on_target_self_destruct() -> void:
	current_lives -= 1
	life_lost.emit(current_lives)
	print('lives left: ', current_lives)
	if current_lives <= 0:
		game_over.emit()
		print('game over')
