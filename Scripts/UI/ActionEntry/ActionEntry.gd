extends LineEdit

class_name ActionEntry

# Declare signal
signal action_submitted(text)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_text_changed(new_text):
	print("text Changes!")
	var is_valid: bool = true # You can implement your validation logic here

	if is_valid:
		emit_signal("action_submitted", new_text)
	else:
		print("Invalid text entered!")
