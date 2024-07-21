extends PathFollow3D
class_name TargetPathFollower

@onready var remote_transform: RemoteTransform3D = $RemoteTransform3D

var target: Target
var base_speed: float = 5.0
var speed_modifier: float = 1.0 # later baby...

func _ready() -> void:
	loop = false
	remote_transform.remote_path = target.get_path()

func set_target(new_target: Target) -> void:
	target = new_target

func _process(delta: float) -> void:
	progress += delta * base_speed * speed_modifier

func _on_target_death() -> void:
	queue_free()
