extends Node

class_name PlaceBase

const PLACE_TRAVEL = "PLACE_TRAVEL"
const PlaceActions: Array[String] = [
	PLACE_TRAVEL,
]
var display_name:String = "PlaceBase"

@export var adjacent_action_items: Array[ActionEntryItem]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func start():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_player_traveled(old_place: PlaceBase, new_location: PlaceBase):
	# if we have arrived at this location, or not, update the actions
	
	# have arrived at this place
	if self == new_location: 
		has_entered_location()
	elif self == old_place:
		has_left_location()

func has_entered_location(): 
	var state = get_play_state()
	state.add_actions(get_available_actions())

func has_left_location():
	pass

func has_inventory():
	return false

func get_adjacent_places() -> Array[PlaceBase]:
	var adjacent_places: Array[PlaceBase] = []
	var parent:Node = get_node("../") # todo: not great, should be encapsulated
	if parent is PlaceBase:
		adjacent_places.append(parent)

	for child in get_children():
		if child is PlaceBase:
			adjacent_places.append(child)
	return adjacent_places

func get_available_actions() -> Array[ActionEntryItem]:
	return []
	
func get_play_state() -> PlayState:
	var game_manager = get_node("/root/root/GameManager")
	return game_manager.current_state
