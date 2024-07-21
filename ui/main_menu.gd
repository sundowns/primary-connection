extends Control

@onready var fullscreen_toggle: CheckButton = $MarginContainer/VBoxContainer/FullscreenToggle
@onready var play: Button = $MarginContainer/VBoxContainer/Play 

@onready var game_scene: PackedScene = preload("res://Game.tscn")

var is_fullscreen: bool = true

func _ready() -> void:
	fullscreen_toggle.button_pressed = is_fullscreen
	set_fullscreen(is_fullscreen)

func set_fullscreen(val: bool) -> void:
	if val:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func start_game() -> void:
	get_tree().change_scene_to_packed(game_scene)

func _on_play_pressed():
	start_game()

func _on_fullscreen_toggle_pressed():
	is_fullscreen = not is_fullscreen
	set_fullscreen(is_fullscreen)
