extends MarginContainer
class_name LifeCounter

@onready var health_container: HBoxContainer = $HealthContainer
@onready var health_icon_scene: PackedScene = preload("res://ui/health_icon.tscn")

func _ready():
	LifeManager.life_lost.connect(self.reduce_life_count)

func initialise():
	var health_count: int = LifeManager.starting_lives
	for i in range(health_count):
		var icon = health_icon_scene.instantiate()
		health_container.add_child(icon)

func reduce_life_count() -> void:
	if LifeManager.current_lives < 0:
		return
	for child in health_container.get_children():
		if child.is_broken:
			continue
		else:
			child.go_broken_style_jutsu()
			break
