extends Node

class_name PlayState

enum PlayStateStatus {
	INITIAL,
	PLAYSTATE_STARTED,
	PLAYING,
}

signal on_playstate_changed(old_status: String, new_status: String)
signal on_player_traveled(old_place: PlaceBase, new_place: PlaceBase)
signal on_actions_changed(new_actions: Array[ActionEntryItem])
signal on_actions_changed_finished()

# Core PlayState Elements - Initial State
@export	var world: PlaceBase # this is the current world
@export var player: Player
@onready var status: String = str(PlayStateStatus.INITIAL)
@onready var current_place: PlaceBase = null
@export var available_actions: Array[ActionEntryItem]

#@onready var current_actions = []
# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("GameStates")
	player = get_node("../../Player")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func start():
	var start_location = _setup_world()
	_set_status(str(PlayStateStatus.PLAYSTATE_STARTED))
	on_player_traveled.connect(player.on_player_traveled)
	# start setting up the game
	travel_player.call_deferred(start_location)

func _setup_world():
	# The following is hardcoded to create the world
	# Create PlaceShop and add it as a parent to a Town Node
	var root:Node = get_node("/root")
	var town:Town = Town.new()
	town.display_name = "TestTown"
	var shop:PlaceShop = PlaceShop.new()
	shop.display_name = "TestShop"

	var rng = RandomNumberGenerator.new()
	for i in 5:
		var cost = rng.randi_range(1, 10)
		var item:Item = Item.new()
		item.cost = cost
		item.display_name = "item_" + str(i)
		shop.inventory.append(item)

	# add to scene
	root.add_child.call_deferred(town)
	town.add_child.call_deferred(shop)

	var cat_item = Item.new()
	cat_item.cost = 100
	cat_item.display_name = "cat_item"

	player.stock_item(cat_item)

	#town.start()
	#shop.start()

	# setup the signal
	on_player_traveled.connect(shop.on_player_traveled)
	on_player_traveled.connect(town.on_player_traveled)
	on_actions_changed.connect(player.on_actions_changed)
	on_actions_changed_finished.connect(player.on_actions_changed_finished)
	world = town
	return town

func travel_player(to_location: PlaceBase):
	var previous_place: PlaceBase = current_place
	current_place = to_location

	# disconnect the signals.. why am I doig this???
	#for connection in on_actions_changed.get_connections():
		#on_actions_changed.disconnect(connection.callable)
	# clear all the actions on travel
	available_actions.clear()

	on_player_traveled.emit(previous_place, current_place)
	# this is assuming that all the actions are added during the travel 
	on_actions_changed_finished.emit()

func _set_status(new_status: String):
	if new_status != status:
		var previous_status: String = status
		status = new_status
		on_playstate_changed.emit(previous_status, status)

func add_actions(new_actions:Array[ActionEntryItem]):
	available_actions += new_actions
	on_actions_changed.emit(available_actions)

func remove_actions(_new_actions:Array[ActionEntryItem]):
	pass
