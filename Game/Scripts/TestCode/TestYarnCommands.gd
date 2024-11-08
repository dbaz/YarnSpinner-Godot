extends Node

class_name TestYarnCommands


# list all default functions of GDScript node class

#@onready var dialog_runner = get_node("../DialogueRunner")
@export var dialog_runner : Node

func string_arg_command(str_command: String):
  print("string_arg_command called")
  print(str_command)

func string_arg():
  print("string_arg called")

func _ready():
  dialog_runner.AddCommandHandlerCallable("string_arg", string_arg_command)
  dialog_runner.AddCommandHandlerCallable("string_arg_command", string_arg)

  #print("dialog_runner")
  #print(dialog_runner)
  #res://addons/YarnSpinner-Godot/Runtime/DialogueRunner.cs
  if dialog_runner is DialogueRunner:
    #print("Setting variable")
    dialog_runner.variableStorage.SetValue("$cat", "3")


func on_call_from_gd_script():
  print("on_call_from_gd_script called")
