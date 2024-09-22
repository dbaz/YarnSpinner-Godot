extends LineEdit

class_name ActionEntry

# Declare signal
signal action_submitted(text)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_text_changed(_entered_text):
	print("text Changes!")

func _on_text_submitted(entered_text):
	print("Cats ON SUMBMITTED ",entered_text)
	action_submitted.emit(entered_text)

