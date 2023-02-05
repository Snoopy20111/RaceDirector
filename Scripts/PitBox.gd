extends Area2D
class_name PitBox

# Declare member variables here. Examples:
export var pitBoxID: int = 1

onready var pitColorRef = $ColorRect
onready var trackRef = get_parent().get_parent()

signal pitbox_area_entered(area, pitBoxID)

func _ready():
	#register with Track
	trackRef._register_PitBox(self, pitBoxID)
# warning-ignore:return_value_discarded
	self.connect("area_entered", self, "_on_Pitbox_Entered")

func _on_Pitbox_Entered(area):
	emit_signal("pitbox_area_entered", area, pitBoxID)

func _set_pitbox_color(newColor: Color) -> void:
	pitColorRef.color = newColor
	#print ("New Color for Pit Box " + String(pitBoxID))

########### Utility Functions ###########
func get_class() -> String:
	return "PitBox"

func is_class(value) -> bool:
	return value == "PitBox"
