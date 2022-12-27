extends PanelContainer


# Declare member variables here. Examples:
onready var label_ref = $Placement

func set_number(newNumber: int = 0) -> void:
	label_ref.text = String(newNumber) + ")"

func set_vertical_size(new_size: int = 50) -> void:
	self.rect_size.y = new_size
	self.rect_min_size.y = new_size
