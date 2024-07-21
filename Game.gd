extends Node3D

@onready var life_counter: LifeCounter = $UI/LifeCounter

@onready var player: Player = $Player
@onready var effects_anchor: Node = $Effects
@onready var first_target_position: Marker3D = $FirstTargetPosition
@onready var target_anchor: Node = $Targets
const max_target_count: int = 5

var target_scene: PackedScene = preload("res://components/target.tscn")

var game_is_over: bool = false

func _ready():
	DependencyHelper.store("Effects", effects_anchor) #🤠
	DependencyHelper.store("Targets", target_anchor) #🤠
	DependencyHelper.store("Player", player) #🤠
	create_starter_target()
	life_counter.initialise()
	LifeManager.game_over.connect(self._on_game_over)

func _input(event: InputEvent):
	if game_is_over: return
	if event.is_action_pressed("fire"):
		player.fire_at_point_on_screen(get_viewport().get_mouse_position())

func _process(_delta: float) -> void:
	for target in target_anchor.get_children():
		target.look_at(player.global_position)

func start_game() -> void:
	LifeManager.start_game()
	SpawnManager.start_game()

func create_starter_target() -> void:
	var first_target: Target = target_scene.instantiate()
	first_target.colour = ColourManager.ColourOption.BLUE 
	first_target.set_as_starter_target()
	target_anchor.add_child(first_target)
	first_target.global_position = first_target_position.global_position
	first_target.destroyed.connect(self._on_starter_target_destroyed)

func _on_starter_target_destroyed() -> void:
	start_game()

func _on_game_over() -> void:
	game_is_over = true
	player.is_disabled = true
	Engine.time_scale = 0
