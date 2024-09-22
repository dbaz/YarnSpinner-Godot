extends PlaceBase

class_name PlaceShop

const SHOP_BUY_ITEM = "BUY_ITEM"
const PlaceShopActions: Array[String] = [
	SHOP_BUY_ITEM,
]

@export var inventory: Array[Item] = []
@export var salesperson: PersonBase = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_inventory() -> Array[Item]:
	return inventory

func get_available_actions() -> Array[ActionEntryItem]:
	var available_actions: Array[ActionEntryItem] = []

	if inventory.size() > 0:
		var action:ActionEntryItem = ActionEntryItem.new()
		action.action_name = SHOP_BUY_ITEM
		action.items_action = get_inventory
		action.select_action = buy_item
		available_actions.append(action)

	return available_actions

func buy_item(item: Item):
	# it's bought, remove it
	var i = inventory.find(item)
	if i >= 0:
		inventory.remove_at(i)

	get_play_state().player.stock_item(item)
	

func stock_item(item: Item):
	# it's sold, add it
	inventory.append(item)
	#TODO: take gold

func has_inventory():
	return inventory.size() > 0;

