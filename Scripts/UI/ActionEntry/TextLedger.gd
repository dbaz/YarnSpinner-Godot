extends TextEdit

class_name TextLedger 

var action_entry_node: ActionEntry = null

signal on_action_submitted_signal(action_json)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_action_entry(action_entry: ActionEntry):
	action_entry_node = action_entry

func on_action_entry_action_submitted(action):
	print("Action is " + action)

# Callback function to handle the signal
func on_text_changed(new_text):
	# Handle the "enter" or "submit" event
	print("OnTextChanged text: " + new_text)

func on_action_submitted(new_text: String):
	# Handle the "enter" or "submit" event
	print("Entered text: " + new_text)
	on_action_submitted_signal.emit(new_text)

func add_text_line(category:String, items_to_display: Array):
	var display_msg = "available actions: %s \n" % [category]
	for i in range(items_to_display.size()):
		display_msg += "%s:\t %s" % [i, items_to_display[i]]
		display_msg += "\n"

		insert_line_at(0, display_msg)
