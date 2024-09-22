extends Node

class_name GameManager

@export var current_state: PlayState

@onready var has_loaded: bool = false
# Called when the node enters the scene tree for the first time.
func _ready():
	_push_game_state(current_state)
	print("GameManager path ")
	print(self.get_path())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not has_loaded:
		has_loaded = true
	
func _push_game_state(state):
	current_state = state
	current_state.start()
	
