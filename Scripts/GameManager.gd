extends Node2D

# Store extra data in here relating to the game
# Driver names, driver standings, Race data, Series info, etc.
# Here ideally is where you can balance and change most things regarding the race as well

var currentTrack
var carCount
var raceType
var raceLaps
var raceMaxLength
var raceTimeElapsed

var default_race_options := {
	"track": "Hungaroring",
	"carCount": 8,
	"raceType": "Circuit",
	"raceLaps": 15,
	"raceMaxLength": 10.0,
}

