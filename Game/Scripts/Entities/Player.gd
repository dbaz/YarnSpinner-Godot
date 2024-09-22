extends Node
class_name Player

@export var action_providers: Array[ActionProviderBase] = []

@export var action_presenter: ActionPresenter

const PLAYER_SELL_ITEM = "PLAYER_SELL_ITEM"
const PLAYER_TRAVEL = "PLAYER_TRAVEL"
const PlayerActions: Array[String] = [
	PLAYER_SELL_ITEM,
	PLAYER_TRAVEL,
]

var current_location: PlaceBase = null
var available_actions: Array[ActionEntryItem]
var inventory: Array[Item] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	await start() # run start in the next frame

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func start():
	action_presenter.on_game_started()

func register_action_provider(provider:ActionProviderBase):
	if provider not in action_providers:
		action_providers.append(provider)
		provider.on_available_actions_changed.connect(on_available_actions_changed)

func unregister_action_provider(provider:ActionProviderBase):
	if provider not in action_providers:
		action_providers.append(provider)
		provider.on_available_actions_changed.connect(on_available_actions_changed)

func on_available_actions_changed(old_actions: Dictionary, new_actions: Dictionary):
	# receive a dictionary of a
	action_presenter.new_actions = new_actions

func on_player_traveled(old_place:PlaceBase, new_place:PlaceBase):
	available_actions.clear()

	if new_place.has_inventory() and get_inventory().size():
		var sell_action = ActionEntryItem.new()
		sell_action.action_name = PLAYER_SELL_ITEM
		sell_action.items_action = get_inventory
		sell_action.select_action = sell_item
		available_actions.append(sell_action)

	if new_place.get_adjacent_places().size():
		var travel_action = ActionEntryItem.new()
		travel_action.action_name = PLAYER_TRAVEL
		travel_action.items_action = new_place.get_adjacent_places
		travel_action.select_action = get_play_state().travel_player
		available_actions.append(travel_action)

	get_play_state().add_actions(available_actions)


func on_actions_changed(new_actions:Array[ActionEntryItem]):
	action_presenter.set_new_actions(new_actions)

func get_current_place_adjacent_places():
	return get_play_state().current_place.adjacent_places

func get_play_state() -> PlayState:
	var game_manager = get_node("/root/root/GameManager")
	return game_manager.current_state

func sell_item(item:Item):
	get_play_state().current_place.stock_item(item)
	get_inventory().erase(item)

func stock_item(item:Item):
	#TODO: check can afford
	get_inventory().append(item)

func on_actions_changed_finished():
	action_presenter.on_actions_changed_finished()

func get_inventory() -> Array[Item]:
	return inventory