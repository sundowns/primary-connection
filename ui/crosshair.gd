extends TextureRect

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED_HIDDEN)
	ColourManager.active_colour_changed.connect(self._on_active_colour_changed)
	LifeManager.game_over.connect(self._on_game_end)

func _process(_delta) -> void:
	var mouse_pos: Vector2  = get_viewport().get_mouse_position()
	global_position = mouse_pos - (size*scale)/2

func _on_active_colour_changed(new_active_colour: ColourManager.ColourOption) -> void:
	self_modulate = ColourManager.colours[new_active_colour]

func _on_game_end():
	visible = false
	set_process(false)
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
