extends Control
class_name DriverListItem

var default_height: int = 50
var expanded_height: int = 120
var is_expanded: bool = false

var carID: int

onready var colorRect_ref = $VBoxContainer/DriverBox/ColorRect
onready var optionsBox_ref = $VBoxContainer/OptionsBox
onready var driverList_ref = self.get_parent().get_parent().get_parent()

func set_color(new_Color: Color) -> void:
	colorRect_ref.color = new_Color

func set_carID(new_CarID: int) -> void:
	carID = new_CarID

func _on_DriverBox_gui_input(event) -> void:
	#If the input event is the left mouse button being pressed
	#Change the visibility of the options box and expand the panel
	if event is InputEventMouseButton:
		if event.is_pressed() && (event.button_index == 1):
			optionsBox_ref.visible = !optionsBox_ref.visible
			is_expanded = !is_expanded
			update_height()

func update_height() -> void:
	if (is_expanded):
		self.rect_size.y = expanded_height
		self.rect_min_size.y = expanded_height
	else:
		self.rect_size.y = default_height
		self.rect_min_size.y = default_height
	print("item_is_expanded: " + String(is_expanded))
	driverList_ref.update_placement_panels()
