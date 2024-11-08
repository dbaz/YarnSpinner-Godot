extends GDScript

class_name ActionEntryItem

var _wrapped_select_action: Callable
var action_name: String
var items_action: Callable
var _of_selection_action: Callable
var play_state = null
var select_action: Callable:
  get:
    return self._wrapped_select_action
  set(value):
    self._wrap_select_action(value)

func inner_wrapped_action(args, action: Callable):
  if self.play_state:
    self.play_state.on_action_triggered.emit(action_name)
  action.call(args)

func _wrap_select_action(action: Callable) -> void:
  self._of_selection_action = action
  self._wrapped_select_action = inner_wrapped_action.bind(self._of_selection_action)
