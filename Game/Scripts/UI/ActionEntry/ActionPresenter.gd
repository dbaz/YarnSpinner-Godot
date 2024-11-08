extends Node

class_name ActionPresenter

# Declare member variables here
@onready var text_ledger_node: TextLedger = get_node("TextLedger")
@onready var action_entry_node: ActionEntry = get_node("ActionEntry")
@onready var game_manager: GameManager = get_node("/root/root/GameManager")
@onready var current_ui_choice: int = -1 # only one "title" deep is supported at the moment, choices in the UI
var current_actions = []
var built_in_commands = {}

func get_play_state() -> PlayState:
	return game_manager.current_state


func on_action_submitted(action_text: String):
	if action_text in built_in_commands:
		built_in_commands[action_text].select_action.call()
		return
	var action_number: int = action_text.to_int()
	
	# they must have entered the index of the action	
	if action_number >= 0:
		if current_ui_choice != -1: # if the player is currently in a menu and they select an action then run the action
			var action_items = current_actions[current_ui_choice].items_action.call()
			if action_number < action_items.size():
				var action_item = action_items[action_number]
				current_actions[current_ui_choice].select_action.call(action_item)

				if current_actions[current_ui_choice].action_name == PlaceShop.SHOP_BUY_ITEM or current_actions[current_ui_choice].action_name == Player.PLAYER_SELL_ITEM:
					refresh()

			else:
				pass

		else:
			# display all the items under the main menu
			var action_name: String = current_actions[action_number].action_name
			current_ui_choice = action_number

			var action_items: Array = [] 
			action_items.append_array( current_actions[action_number].items_action.call() )
			if action_items.size():
				display_items(action_name, action_items)
			else:
				text_ledger_node.add_text_line("", ["No items available for this action."])
	else:
		print("Unknown action!")

func _create_back_action():
	var back_action: ActionEntryItem = ActionEntryItem.new()
	back_action.play_state = get_play_state()
	back_action.action_name = "Back"
	back_action.items_action = Callable()
	back_action.select_action = back
	return back_action

func refresh():
	if current_ui_choice != -1:
		display_items(current_actions[current_ui_choice].action_name, current_actions[current_ui_choice].items_action.call())
	else:
		var action_names: Array[String] = []
		for k in current_actions:
			action_names.append(k.action_name)
		display_items("", action_names)

func back():
	current_ui_choice = -1
	refresh()

func on_game_started():
	var back_action: ActionEntryItem = ActionEntryItem.new()
	back_action.play_state = get_play_state()
	back_action.items_action = Callable()
	back_action.select_action = back
	built_in_commands = {"Back": back_action}

	text_ledger_node.add_text_line("", ["Welcome to Gods!"])
	game_manager.current_state.on_player_traveled.connect(on_player_traveled)


func _get_player():
	return game_manager.current_state.player

func on_player_traveled(_old_place: PlaceBase, new_place: PlaceBase):
	if new_place is PlaceShop:
		#var purchase_lambda = func purchase(purchased_item: Item):
		#print_debug("Purchase lambda called: " + purchased_item.name)
		pass


func on_playstate_changed(_previous_state: PlayState.PlayStateStatus, new_status: PlayState.PlayStateStatus):
	#game_manager.current_state
	if new_status == PlayState.PlayStateStatus.PLAYSTATE_STARTED:
		on_game_started()


func set_new_actions(action_objects: Array[ActionEntryItem]):
	current_ui_choice = -1
	current_actions = action_objects


func on_actions_changed_finished():
	var action_names: Array[String] = []
	for k in current_actions:
		print("adding action " + k.action_name)
		action_names.append(k.action_name)
	
	text_ledger_node.clear()
	display_items("", action_names)


func display_items(category: String, items_to_display: Array):
	var action_names: Array[String] = []

	for action_item in items_to_display:
		if action_item is PlaceBase:
			action_names.append(action_item.display_name)
		elif action_item is Item:
			action_names.append(action_item.display_name)
		elif action_item is String:
			action_names.append(action_item)
		else:
			print("Unknown action item type: " + str(action_item))

	text_ledger_node.add_text_line(category, action_names)


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get all the required Nodes
	if text_ledger_node != null and action_entry_node != null:
		var path: NodePath = get_path()
		# Convert the NodePath to a string
		var path_string: String = str(path)
		print("Current node path: " + path_string)
		# Print the path
		_setup_ui_callbacks()


func _setup_ui_callbacks():
	if text_ledger_node != null:
		# Connect the text_ledger to the action_entry
		action_entry_node.connect("action_submitted", _on_action_entry_action_submitted)
		action_entry_node.connect("text_changed", _on_text_changed)
		# action_entry_node.connect(on_action_submitted)
	else:
		print("TextLedger script not found.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

# action from entry node
func _on_action_entry_action_submitted(action_text):
	on_action_submitted(action_text)


# Callback function to handle the signal
func _on_text_changed(new_text):
	# Handle the "enter" or "submit" event
	print("Cats " + new_text)
