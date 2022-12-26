extends PanelContainer


# Declare member variables here. Examples:
onready var label_ref = $Placement

func set_number(newNumber: int = 0) -> void:
	label_ref.text = String(newNumber) + ")"
