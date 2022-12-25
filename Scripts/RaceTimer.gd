extends PanelContainer


# Declare member variables here. Examples:
var time_in_seconds: float = 0
var is_time_paused: bool = true
var is_showing_full_time: bool = false
onready var time_text_ref: Label = $VBoxContainer/Time

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!is_time_paused):
		time_in_seconds += delta
	print_time()
	
func print_time():
#minutes calculation
# warning-ignore:narrowing_conversion
	var minutes: int = (time_in_seconds / 60)
	var minutes_string: String
	if (minutes < 10):
		minutes_string = "0" + String(minutes)
	else:
		minutes_string = String(minutes)

#hours calculation, done second because it depends on minutes
# warning-ignore:integer_division
	var hours: int = (minutes / 60)
	var hours_string: String
	if (hours < 10):
		hours_string = "0" + String(hours)
	else:
		hours_string = String(hours)

#seconds calculation, done last because it depends on minutes & hours
	var seconds: int = int(time_in_seconds) - (minutes * 60) - (hours * 360)
	var seconds_string: String
	if (seconds < 10):
		seconds_string = "0" + String(seconds)
	else:
		seconds_string = String(seconds)

	#var seconds: float = time_in_seconds - float(minutes * 60) - float(hours * 360)
	time_text_ref.text = String(hours_string) + ":" + String(minutes_string) + ":" + String(seconds_string)

func unpause_timer():
	is_time_paused = false

func pause_timer():
	is_time_paused = true

func end_race():
	is_time_paused = true
	is_showing_full_time = true
