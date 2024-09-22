extends PlaceBase

class_name Town

func start():
	super.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func has_entered_location():
	# var state = get_play_state()
	# state.add_actions(adjacent_action_items)
	super.has_entered_location()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func has_left_location():
	pass
