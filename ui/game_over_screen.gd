extends Control
class_name GameOverScreen

@onready var elapsed_time_label: RichTextLabel = $MarginContainer/Control/VBoxContainer/CenterContainer2/ElapsedTime
@onready var targets_destroyed_label: RichTextLabel = $MarginContainer/Control/VBoxContainer/CenterContainer/TargetsDestroyed

const elapsed_time_template: String = "You survived for [color=green]%s m, %s s[/color]"
const targets_destroyed_template: String = "Targets destroyed: [color=orange]%d[/color]"

func _ready():
	visible = false
	LifeManager.game_over.connect(self._on_game_over)

func _on_game_over(): 
	visible = true
	@warning_ignore("integer_division")
	var minutes: int = int(LifeManager.time_elapsed) / 60
	var seconds: int = int(LifeManager.time_elapsed) % 60
	elapsed_time_label.text = elapsed_time_template % [minutes, seconds]
	targets_destroyed_label.text = targets_destroyed_template % LifeManager.targets_destroyed

func _on_restart_pressed():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()

func _on_close_pressed():
	get_tree().quit()
