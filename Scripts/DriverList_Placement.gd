extends Panel
class_name DriverListPlacement


# Declare member variables here. Examples:
export var default_height: int = 50
export var expanded_height: int = 120
var item_is_expanded: bool = false

onready var label_ref = $Placement

func set_number(newNumber: int = 0) -> void:
	label_ref.text = String(newNumber) + ")"
	
func set_expanded(new_state: bool) -> void:
	item_is_expanded = new_state
	update_height()

func update_height() -> void:
	if (item_is_expanded):
		self.rect_size.y = expanded_height
		self.rect_min_size.y = expanded_height
	else:
		self.rect_size.y = default_height
		self.rect_min_size.y = default_height
	#print("item_is_expanded: " + String(item_is_expanded))
