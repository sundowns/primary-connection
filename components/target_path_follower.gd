extends PathFollow3D
class_name TargetPathFollower

@onready var remote_transform: RemoteTransform3D = $RemoteTransform3D

var target: Target
var base_speed: float = 4.0
var speed_modifier: float = 1.0 # later baby...

const delay_before_removing_after_completion: float = 0.5

func _ready() -> void:
	loop = false
	remote_transform.remote_path = target.get_path()

func set_target(new_target: Target) -> void:
	target = new_target

func _process(delta: float) -> void:
	progress += delta * base_speed * speed_modifier
	if progress_ratio >= 1.0:
		set_process(false)
		path_completed()

func _on_target_death() -> void:
	queue_free()

func path_completed() -> void:
	await get_tree().create_timer(delay_before_removing_after_completion).timeout
	if target and is_instance_valid(target) and not target.is_queued_for_deletion():
		target.switch_to_move_towards_player(base_speed * speed_modifier)
	queue_free()
