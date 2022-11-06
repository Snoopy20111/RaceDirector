extends Node2D

# Store extra data in here relating to the game
# Driver names, driver standings, Race data, Series info, etc.
# Here ideally is where you can balance and change most things regarding the race as well

var raceTimeElapsed: float

# audio variables
var hasInitializedAudio: bool = false

var defaultRaceOptions: Dictionary = {
	"track": "Default_Track",
	"carCount": 4,
	"raceType": Enums.RACE_TYPE.CIRCUIT,
	"raceLaps": 15,
	"raceLength": 6.0,
	"raceMaxLength": 10.0,
}

var currentRaceOptions: Dictionary = defaultRaceOptions

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
	

### Utilities ###

func _prerace_set_track(newTrack: String) -> void:
	currentRaceOptions.track = newTrack

func _prerace_set_carCount(newValue: int) -> void:
	currentRaceOptions.carCount = newValue

func _prerace_set_raceType(newRaceType: int) -> void:
	#Only to be used with RaceType enum values
	currentRaceOptions.raceType = newRaceType

func _prerace_set_raceLaps(newLapCount: int) -> void:
	currentRaceOptions.raceLaps = newLapCount

func _prerace_set_raceLength(newLength: float) -> void:
	currentRaceOptions.raceLength = newLength

func _prerace_set_raceMaxLength(newMaxLength: float) -> void:
	currentRaceOptions.raceMaxLength = newMaxLength

func _reset_race_options() -> void:
	currentRaceOptions = defaultRaceOptions
