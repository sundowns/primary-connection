extends Node3D

@onready var player: Player = $Player

func _input(event: InputEvent):
	if event.is_action_pressed("fire"):
		player.fire_at_point_on_screen(get_viewport().get_mouse_position())
