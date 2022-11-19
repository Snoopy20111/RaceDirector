extends HSlider


# Declare member variables here. Examples:
var init_sound = true


func _on_GridContainer_CountUpdated(newCount):
	value = float(newCount)
