extends PanelContainer


# Declare member variables here. Examples:
var time_in_seconds: float = 0
var is_showing_full_time: bool = false
onready var time_text_ref: Label = $VBoxContainer/Time

func _ready():
# warning-ignore:return_value_discarded
	GameManager.connect("race_started", self, "on_Race_Start")
# warning-ignore:return_value_discarded
	GameManager.connect("race_ended", self, "on_Race_End")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (GameManager.is_race_active):
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

#seconds calculation, done last because it depends on minutes & hours and may be float/int
	var seconds_float: float = stepify(time_in_seconds - float(minutes * 60) - float(hours * 360),0.001)
	var seconds_int: int = int(seconds_float)
	var seconds_string: String
	
	#messy junk to define the string we need w/decimals and/or leading zero
	if (!is_showing_full_time && (seconds_int < 10)):
		seconds_string = "0" + String(seconds_int)
	elif (!is_showing_full_time):
		seconds_string = String(seconds_int)
	elif (seconds_float < 10):
		seconds_string = "0" + String(seconds_float)
	else:
		seconds_string = String(seconds_float)

	time_text_ref.text = String(hours_string) + ":" + String(minutes_string) + ":" + String(seconds_string)

func unpause_timer():
	pass

func pause_timer():
	pass

func on_Race_Start():
	pass

func on_Race_End():
	is_showing_full_time = true
	GameManager.last_recorded_time = time_in_seconds
	print (time_in_seconds)
