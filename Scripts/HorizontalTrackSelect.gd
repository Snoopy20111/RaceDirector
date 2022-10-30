extends Panel


# Declare member variables here. Examples:
var trackList: Array = TrackDataMapping._get_playable_list()
onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	if (!trackList.empty()):
		label.text = trackList[0]
	else:
		label.text = "Default_Track"
	# For every key in the track array where isListed is false, remove it
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Left_pressed():
	pass # Replace with function body.


func _on_Right_pressed():
	pass # Replace with function body.
