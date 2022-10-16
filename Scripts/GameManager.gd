extends Node2D

# Store extra data in here relating to the game
# Driver names, driver standings, Race data, Series info, etc.
# Here ideally is where you can balance and change most things regarding the race as well

var currentTrack: String
var carCount: int
var raceType: String
var raceLaps: int
var raceLength: float
var raceMaxLength: int
var raceTimeElapsed: int

# audio variables
var hasInitializedAudio: bool = false


var default_race_options: Dictionary = {
	"track": "Hungaroring",
	"carCount": 8,
	"raceType": "Circuit",
	"raceLaps": 15,
	"raceMaxLength": 10.0,
}

func _init_FMOD():
	if (hasInitializedAudio == false):
		
		# set up FMOD
		Fmod.set_software_format(0, Fmod.FMOD_SPEAKERMODE_STEREO, 0)
		Fmod.init(1024, Fmod.FMOD_STUDIO_INIT_LIVEUPDATE, Fmod.FMOD_INIT_NORMAL)
	
		# Load default FMOD banks
		Fmod.load_bank("res://Audio/Banks/Desktop/Master.strings.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
		Fmod.load_bank("res://Audio/Banks/Desktop/Master.bank", Fmod.FMOD_STUDIO_LOAD_BANK_NORMAL)
		
		# Add a listener
		Fmod.add_listener(0, self)
		
		# And make sure we can't do this twice
		hasInitializedAudio = true
