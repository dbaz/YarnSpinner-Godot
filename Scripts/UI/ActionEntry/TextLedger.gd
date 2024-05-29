extends TextEdit

class_name TextLedger 

var action_entry_node: ActionEntry = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_action_entry(action_entry):
	action_entry_node = action_entry

func on_action_entry_action_submitted(action):
	print("Action is " + action)

# Callback function to handle the signal
func on_text_changed(new_text):
	# Handle the "enter" or "submit" event
	print("OnTextChanged text: " + new_text)

func on_action_submitted(new_text):
	# Handle the "enter" or "submit" event
	print("Entered text: " + new_text)

func debug_shot_text(new_text):
	print("Adding new text")
	insert_line_at(-1,new_text)
