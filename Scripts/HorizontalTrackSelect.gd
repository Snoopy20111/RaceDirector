extends Panel


# Declare member variables here
export var loopSelection = true

var trackList: Array = TrackDataMapping._get_playable_list()
onready var label: Label = $Label
onready var trackListMax: int = trackList.size() - 1
var currentTrack: int = 0

signal NewTrackSelected(name)
signal NewTrackRange(newMin, newMax)

# Called when the node enters the scene tree for the first time.
func _ready():
	if (!trackList.empty()):
		label.text = trackList[0]
	else:
		label.text = "Default_Track"


func _on_Left_pressed():
	if (isInBounds(currentTrack - 1)):
		currentTrack -= 1
	else:
		currentTrack = trackListMax
	label.text = trackList[currentTrack]
	emit_signal("NewTrackSelected", trackList[currentTrack])
	emit_signal("NewTrackRange", 2, TrackDataMapping._get_maxCars(trackList[currentTrack]))


func _on_Right_pressed():
	if (isInBounds(currentTrack + 1)):
		currentTrack += 1
	else:
		currentTrack = 0
	label.text = trackList[currentTrack]
	emit_signal("NewTrackSelected", trackList[currentTrack])
	emit_signal("NewTrackRange", 2, TrackDataMapping._get_maxCars(trackList[currentTrack]))


func isInBounds(value: int) -> bool:
	if (value >= 0) and (value <= trackListMax):
		return true
	else:
		return false
