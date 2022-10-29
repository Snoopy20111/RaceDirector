extends GridContainer


# Declare member variables here. Examples:
var Count: int = 2

signal CountUpdated(newCount)
export var leftText: String = "Text"
onready var leftTextBox = $PanelContainer02/Label
export var minValue: int = 0
export var maxValue: int = 99
export var tickDivider: int = 1
onready var mySlider: HSlider = $PanelContainer/VBoxContainer/Slider
onready var myLineEdit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	leftTextBox.text = leftText
	mySlider.min_value = minValue
	mySlider.max_value = maxValue
	mySlider.value = maxValue
	myLineEdit.placeholder_text = String(maxValue)
	mySlider.tick_count = int((abs(abs(maxValue+1)-abs(minValue))) / tickDivider)

func _on_Slider_value_changed(value):
	Count = int(value)
	emit_signal("CountUpdated", Count)


func _on_LineEdit_text_entered(new_text):
	Count = int(new_text)
	emit_signal("CountUpdated", Count)
