extends HSlider


# Declare member variables here. Examples:
export var sliderMove_FMOD_path: String = "event:/UI/Nav_Slider"


# Called when the node enters the scene tree for the first time.
func _ready():
# warning-ignore:return_value_discarded
	connect("value_changed", self, "onSliderMove")


func onSliderMove(_value: float):
	Fmod.play_one_shot(sliderMove_FMOD_path, self)
	print("slider move")
