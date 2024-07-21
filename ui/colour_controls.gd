extends MarginContainer
class_name ColourControls

@onready var red_node: ColourControlNode = $Control/Nodes/RedNode
@onready var yellow_node: ColourControlNode = $Control/Nodes/YellowNode
@onready var blue_node: ColourControlNode = $Control/Nodes/BlueNode

@onready var product_colour: TextureRect = $Control/Nodes/Overlays/MarginContainer/CentreContainer/ProductColour
@onready var red_connection: TextureRect = $Control/Nodes/Overlays/Connections/RedConnection
@onready var yellow_connection: TextureRect = $Control/Nodes/Overlays/Connections/YellowConnection
@onready var blue_connection: TextureRect = $Control/Nodes/Overlays/Connections/BlueConnection

func _ready():
	LifeManager.game_over.connect(self._on_game_over)
	call_deferred("colours_changed")
	ColourManager.active_colour_changed.connect(self._on_active_colour_change)
	red_connection.self_modulate = ColourManager.colours[ColourManager.ColourOption.RED]
	yellow_connection.self_modulate = ColourManager.colours[ColourManager.ColourOption.YELLOW]
	blue_connection.self_modulate = ColourManager.colours[ColourManager.ColourOption.BLUE]

func _input(event: InputEvent):
	var any_node_was_toggled: bool = false
	if event.is_action_pressed("toggle_red"):
		red_node.toggle()
		any_node_was_toggled = true
	elif event.is_action_pressed("toggle_yellow"):
		yellow_node.toggle()
		any_node_was_toggled = true
	elif event.is_action_pressed("toggle_blue"):
		blue_node.toggle()
		any_node_was_toggled = true
	if any_node_was_toggled:
		colours_changed()

func colours_changed() -> void:
	ColourManager.colour_changed(red_node.is_enabled, yellow_node.is_enabled, blue_node.is_enabled)

func _on_active_colour_change(new_colour: ColourManager.ColourOption) -> void:
	var colour: Color = ColourManager.colours[new_colour]
	product_colour.self_modulate = colour
	yellow_connection.visible = yellow_node.is_enabled
	yellow_connection.self_modulate = colour
	red_connection.visible = red_node.is_enabled
	red_connection.self_modulate = colour
	blue_connection.visible = blue_node.is_enabled
	blue_connection.self_modulate = colour

func _on_game_over() -> void:
	set_process_input(false)
