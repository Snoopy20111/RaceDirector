extends Node2D

# Store extra data in here relating to the game
# Driver names, driver standings, Race data, Series info, etc.
# Here ideally is where you can balance and change most things regarding the race as well

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

var is_paused: bool = false
var is_race_active: bool = false

var currentRaceOptions: Dictionary = defaultRaceOptions

var racerDataArray: Array
var racerStandingArray: PoolIntArray

onready var name_gen = NameGenerator.new()


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
	_generate_driver_nationalities()
	_generate_driver_names()
	print ("Racer Data generated")

func _generate_car_colors() -> void:
	
	#If we already have car colors, get rid of them!
	for i in racerDataArray.size():
		racerDataArray[i].reset_color()
	
	var possibleCarColors: Array; possibleCarColors.resize(255)
	var hueRadius = 15
	for i in possibleCarColors.size():
		possibleCarColors[i] = i
	
	for i in currentRaceOptions.carCount:
		
		#generate custom colors with random Hue and random in range saturation
		# and brightness, with no duplicates
		var tempRand := randi() % possibleCarColors.size()
		#print("tempRand Cell: " + String(tempRand) + " and tempRand Value: " + String(possibleCarColors[tempRand]))
		racerDataArray[i].car_color = Color.from_hsv(float(possibleCarColors[tempRand]) / 255, 1, rand_range(0.6, .9))
		#carColors[i] = Color.from_hsv(float(possibleCarColors[tempRand]) / 255, 1, rand_range(0.6, .9))
		print("Car Color: " + String(racerDataArray[i].car_color))
		
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

func _generate_driver_nationalities() -> void:
	for i in racerDataArray.size():
		racerDataArray[i].driver_nationality = name_gen.get_nationality()
		print("Driver #" + String(i) + " given nationality " + String(racerDataArray[i].driver_nationality))

func _generate_driver_names() -> void:
	for i in racerDataArray.size():
		var nationality = racerDataArray[i].driver_nationality
		racerDataArray[i].driver_name = name_gen.get_driver_name(nationality)
		#print("Racer #" + String(i) + " named " + racerDataArray[i].driver_name)


### In-Race Updates and data ###
func _race_car_lap_completed(givenCarID: int = 0) -> void:
	racerDataArray[givenCarID].current_lap += 1

func _race_car_position_update(givenCarID: int, trackPosition: float) -> void:
	racerDataArray[givenCarID].current_lap_progress = trackPosition

func _get_drivers_ordered() -> PoolIntArray:
	_sort_driver_standings()
	#todo: pass this data in a way that is more efficient, because
	#it has to be unsorted the same way on the other side
	return racerStandingArray

func _sort_driver_standings() -> void:	
	#resize to zero, we'll add our elements in from here
	racerStandingArray.resize(0)
	var tempArray = racerDataArray.duplicate()
	
	#put the currentCarIDs in order based on racerProgresses
	#todo: better sorting algorithm, because this is pretty much brute force
	for i in racerDataArray.size():
		var carIDFound: int
		var largestValueFound: float
		var jValue: int
		for j in tempArray.size():
			#Find the largest racerProgress value in the temp set and set largestValueFound to it
			var racerProgress: float = float(tempArray[j].current_lap) + tempArray[j].current_lap_progress
			print ("Racer Progress for car " + String(tempArray[j].carID) + " is " + String(racerProgress))
			if (racerProgress > largestValueFound):
				largestValueFound = racerProgress
				carIDFound = tempArray[j].carID
				jValue = j
		#with our new value for largest found, we append the carID to our Standing Array
		racerStandingArray.append(carIDFound)
		#and remove that element from tempArray, before doing it all again
		tempArray.remove(jValue)
	#by this point, racerStandingArray should be the car IDs in order

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
