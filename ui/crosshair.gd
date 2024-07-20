extends TextureRect

func _ready() -> void:
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_CONFINED_HIDDEN)

func _process(_delta) -> void:
	var mouse_pos: Vector2  = get_viewport().get_mouse_position()
	global_position = mouse_pos - (size*scale)/2
