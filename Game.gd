extends Node3D

@onready var player: Player = $Player
@onready var effects_anchor: Node = $Effects

@onready var target_anchor: Node = $Targets
@onready var spawn_targets_timer: Timer = $SpawnTargetsInterval
const max_target_count: int = 5

var target_scene: PackedScene = preload("res://components/target.tscn")

func _ready():
	DependencyHelper.store("Effects", effects_anchor) #🤠
	call_deferred("spawn_targets")

func _input(event: InputEvent):
	if event.is_action_pressed("fire"):
		player.fire_at_point_on_screen(get_viewport().get_mouse_position())

func _process(_delta: float) -> void:
	for target in target_anchor.get_children():
		target.look_at(player.global_position)

func _on_spawn_targets_interval_timeout():
	spawn_targets()

func spawn_targets() -> void:
	var current_target_count: int = target_anchor.get_child_count()
	if current_target_count < max_target_count:
		# spawn some new baddies
		var difference: int = max_target_count - current_target_count
		for i in range(difference):
			var colour := ColourManager.get_random_colour()
			var new_target: Target = target_scene.instantiate()
			new_target.colour = colour
			target_anchor.add_child(new_target)
			new_target.position += Vector3(randf_range(-2.5, 2.5), randf_range(-0.75, 1.5), randf_range(3, 8))
