extends Node2D

# Store extra data in here relating to the game
# Driver names, driver standings, Race data, Series info, etc.
# Here ideally is where you can balance and change most things regarding the race as well

var raceTimeElapsed: float

# audio variables
var hasInitializedAudio: bool = false

var defaultRaceOptions: Dictionary = {
	"track": "Default_Track",
	"carCount": 6,
	"raceType": Enums.RACE_TYPE.CIRCUIT,
	"raceLaps": 10,
	"raceLengthMinutes": 6.0,
	"raceMaxLengthMinutes": 10.0,
}

var currentRaceOptions: Dictionary = defaultRaceOptions

var racerDataArray: Array

var driverNameArray: PoolStringArray
var carColors: PoolColorArray

func _init_FMOD():
	
	if (hasInitializedAudio == false):
		
		# set up FMOD
		Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
		Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
	
		# Load default FMOD banks
# warning-ignore:return_value_discarded
		Fmod.load_bank("res://Audio/Banks/Desktop/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
# warning-ignore:return_value_discarded
		Fmod.load_bank("res://Audio/Banks/Desktop/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
		
		# Add a listener
		Fmod.add_listener(0, self)
		
		# And make sure we can't do this twice
		hasInitializedAudio = true

### Race Options Utilities ###

func _prerace_set_track(newTrack: String) -> void:
	currentRaceOptions.track = newTrack
	print ("Track updated to " + String(currentRaceOptions.track))

func _prerace_set_carCount(newValue: int) -> void:
	currentRaceOptions.carCount = newValue
	print ("Car Count updated to " + String(currentRaceOptions.carCount))

func _prerace_set_raceType(newRaceType: int) -> void:
	#Only to be used with RaceType enum values
	currentRaceOptions.raceType = newRaceType
	print ("RaceType updated to " + String(currentRaceOptions.raceType))

func _prerace_set_raceLaps(newLapCount: int) -> void:
	currentRaceOptions.raceLaps = newLapCount
	print ("RaceLaps updated to " + String(currentRaceOptions.raceLaps))

func _prerace_set_raceLengthMinutes(newLength: float) -> void:
	currentRaceOptions.raceLengthMinutes = newLength
	print ("RaceLength updated to " + String(currentRaceOptions.raceLengthMinutes))

func _prerace_set_raceMaxLengthMinutes(newMaxLength: float) -> void:
	currentRaceOptions.raceMaxLengthMinutes = newMaxLength
	print ("RaceMaxLength updated to " + String(currentRaceOptions.raceMaxLengthMinutes))

func _reset_race_options() -> void:
	currentRaceOptions = defaultRaceOptions
	print ("Race Options reset")

### Cars, colors, drivers, etc ###
func _generate_racer_data() -> void:
	racerDataArray.resize(currentRaceOptions.carCount)
	for i in racerDataArray.size():
		racerDataArray[i] = RacerData.new()
		racerDataArray[i].init_racer_data(i)
	_generate_car_colors()
	_generate_driver_names()

func _generate_car_colors() -> void:
	
	#If we already have car colors, get rid of them!
	carColors.resize(currentRaceOptions.carCount)
	var possibleCarColors: Array; possibleCarColors.resize(255)
	var hueRadius = 15
	for i in possibleCarColors.size():
		possibleCarColors[i] = i
	
	for i in currentRaceOptions.carCount:
		
		#generate custom colors with random Hue and random in range saturation
		# and brightness, with no duplicates
		var tempRand := randi() % possibleCarColors.size()
		#print("tempRand Cell: " + String(tempRand) + " and tempRand Value: " + String(possibleCarColors[tempRand]))
		carColors[i] = Color.from_hsv(float(possibleCarColors[tempRand]) / 255, 1, rand_range(0.6, .9))
		print("Car Color: " + String(carColors[i]))
		
		#remove used color(s) from pool by slicing and splicing the given range out
		var tempRandLocation := possibleCarColors.find(tempRand)
		var lowerSlice: Array
		var upperSlice: Array
		
		if (tempRandLocation >= hueRadius):
			lowerSlice = possibleCarColors.slice(0, tempRandLocation - hueRadius, 1, false)
		if ((tempRandLocation + hueRadius) < possibleCarColors.size()):
			upperSlice = possibleCarColors.slice(tempRandLocation + hueRadius, possibleCarColors.size(), 1, false)
			
		lowerSlice.append_array(upperSlice)
		possibleCarColors = lowerSlice

func _generate_driver_names() -> void:
	driverNameArray.resize(currentRaceOptions.carCount)
	for i in driverNameArray.size():
		driverNameArray[i] = "Driver Lastname " + String(i)

func _race_car_lap_completed(carID: int = 0) -> void:
	racerDataArray[carID].current_lap += 1

func _get_driver_standings() -> void:
	pass

### Utilities ###
func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)

func findByClass(node: Node, className : String, result : Array) -> void:
	if node.is_class(className):
		result.push_back(node)
	for child in node.get_children():
		findByClass(child, className, result)
