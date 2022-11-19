extends GridContainer


# Declare member variables here. Examples:
var Count: int = 2


signal CountUpdatedFromSlider(newCount)
signal CountUpdatedFromText(newCount)

export var leftText: String = "Text"
export var minValue: int = 0
export var maxValue: int = 99
export var tickDivider: int = 1

export var sliderMove_FMOD_path: String = "event:/UI/Nav_Slider"

onready var leftTextBox = $PanelContainer02/Label
onready var mySlider = $PanelContainer/VBoxContainer/Slider
onready var myLineEdit = $LineEdit

# Called when the node enters the scene tree for the first time.
func _ready():
	leftTextBox.text = leftText
	mySlider.min_value = minValue
	mySlider.max_value = maxValue
	mySlider.value = maxValue
	myLineEdit.placeholder_text = String(maxValue)
	mySlider.tick_count = int((abs(abs(maxValue+1)-abs(minValue))) / tickDivider)


func _on_Slider_value_changed(value) -> void:
	Count = int(value)
	if (mySlider.init_sound == false):
		Fmod.play_one_shot(sliderMove_FMOD_path, self)
	else:
		mySlider.init_sound = false
	emit_signal("CountUpdatedFromSlider", Count)


func _on_LineEdit_text_entered(new_text) -> void:
	Count = int(new_text)
	mySlider.gridContainerWasUpdated = true
	emit_signal("CountUpdatedFromText", Count)


func _on_new_MaxValue(value) -> void:
	mySlider.max_value = value
	mySlider.tick_count = int((abs(abs(value+1)-abs(minValue))) / tickDivider)
	

func _on_new_MinValue(value) -> void:
	mySlider.min_value = value
	mySlider.tick_count = int((abs(abs(maxValue+1)-abs(value))) / tickDivider)


func _on_new_Range(newMinValue, newMaxValue) -> void:
	print("New Range!")
	mySlider.min_value = newMinValue
	mySlider.max_value = newMaxValue
	mySlider.tick_count = int((abs(abs(newMaxValue+1)-abs(newMinValue))) / tickDivider)
