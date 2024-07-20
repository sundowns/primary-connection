extends MarginContainer
class_name ColourControls

@onready var red_node: ColourControlNode = $Control/Nodes/RedNode
@onready var yellow_node: ColourControlNode = $Control/Nodes/YellowNode
@onready var blue_node: ColourControlNode = $Control/Nodes/BlueNode

func _ready():
	call_deferred("colours_changed")

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
	# TODO: update the connections and probably some central pretty thing to show colour
