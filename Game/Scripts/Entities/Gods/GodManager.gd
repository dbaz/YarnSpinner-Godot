extends Node

class_name GodManager

# assign a yarnspinner file as a variable
@export var god_data_file: String = "res://Scripts/Entities/Gods/Data/GodsData.json"
@export var god_scene_template: PackedScene
@export var god_root: Node # the place where we will spawn the active gods
var gods_data: Dictionary = {}

# Called when the node enters the scene tree for the first time.
func _ready():
    self.gods_data = self._load_json_from_file(self.god_data)
    self.initialise_gods()


func _load_json_from_file(path: String) -> Dictionary:
    var file = FileAccess.open(path, FileAccess.READ)
    if file:
        var json_string = file.get_as_text()
        file.close()
        var json = JSON.new()
        var json_result = json.parse(json_string)
        
        if json_result.error == OK:
            return json_result.result
        else:
            print("Error parsing JSON: ", json_result.error_string)
            return {}
    else:
        print("Failed to open JSON file.")
        return {}


func initialise_gods() -> void:
    var god_names = self.gods_data.keys()
    for god in god_names:
        var god_instance = God.new()
        god_instance.initialise()


func activate_gods(god_names: Array):
    pass


func available_gods():
    return

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
  pass
