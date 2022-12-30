extends Control

var default_height: int = 50
var expanded_height: int = 120
var item_is_expanded: bool = false

var carID: int

onready var colorRect_ref = $VBoxContainer/DriverBox/ColorRect
onready var optionsBox_ref = $VBoxContainer/OptionsBox

func set_color(newColor: Color) -> void:
	colorRect_ref.color = newColor

func set_carID(newCarID: int) -> void:
	carID = newCarID

func _on_DriverBox_gui_input(event) -> void:
	#If the input event is the left mouse button being pressed
	#Change the visibility of the options box and expand the panel
	if event is InputEventMouseButton:
		if event.is_pressed() && (event.button_index == 1):
			optionsBox_ref.visible = !optionsBox_ref.visible
			item_is_expanded = !item_is_expanded
			if (item_is_expanded):
				self.rect_size.y = expanded_height
				self.rect_min_size.y = expanded_height
			else:
				self.rect_size.y = default_height
				self.rect_min_size.y = default_height
