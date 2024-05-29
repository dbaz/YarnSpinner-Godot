extends Node


class_name ActionPresenter


# Declare member variables here
var text_ledger_node: TextLedger = null
var action_entry_node: ActionEntry = null

# Called when the node enters the scene tree for the first time.
func _ready():
	# Get all the required Nodes
	text_ledger_node = get_node_or_null("TextLedger")
	action_entry_node = get_node_or_null("ActionEntry")

	if text_ledger_node != null and action_entry_node != null:
		var path: NodePath = get_path()
		# Convert the NodePath to a string
		var path_string: String = str(path)
		# Print the path
		print("Current node path: " + path_string)
		setup_ui_callbacks()


func setup_ui_callbacks():
	if text_ledger_node != null:
		# Connect the text_ledger to the action_entry
		action_entry_node.connect("action_submitted", _on_action_entry_action_submitted)
		action_entry_node.connect("text_changed", _on_text_changed)
		# action_entry_node.connect(on_action_submitted)
	else:
		print("TextLedger script not found.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# action from entry node
func _on_action_entry_action_submitted(action):
	print("Action is " + action)

# Callback function to handle the signal
func _on_text_changed(new_text):
	# Handle the "enter" or "submit" event
	print("Cats " + new_text)

func on_action_submitted(new_text):
	# Handle the "enter" or "submit" event
	print("Entered text: " + new_text)

