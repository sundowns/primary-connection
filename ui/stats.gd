extends Control

@onready var elasped_time: Label = $VBoxContainer/ElapsedTime
@onready var targets_destroyed: Label = $VBoxContainer/TargetsDestroyed

const elapsed_time_template: String = "%s m, %s s"
const elapsed_time_template_pre_minutes: String = "%s s"
const targets_destroyed_template: String = "Targets: %d"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	@warning_ignore("integer_division")
	var minutes: int = int(LifeManager.time_elapsed) / 60
	var seconds: int = int(LifeManager.time_elapsed) % 60
	if minutes > 0:
		elasped_time.text = elapsed_time_template % [minutes, seconds]
	else:
		elasped_time.text = elapsed_time_template_pre_minutes % [seconds]
	targets_destroyed.text = targets_destroyed_template % LifeManager.targets_destroyed
