extends Reference
class_name TrackDataMapping

# Individual Tracks
const Default_Track: Dictionary = {
	"name": "Default Track",
	"path": "res://Scenes/Tracks/StartYourEngines.tscn",
	"maxCars": 6,
	"isListed": false
}
const Hungaroring: Dictionary = {
	"name": "Hungaroring",
	"path": "res://Scenes/Tracks/StartYourEngines.tscn",
	"maxCars": 12,
	"isListed": true
}
const Silverstone: Dictionary = {
	"name": "Silverstone",
	"path": "res://Scenes/Tracks/StartYourEngines.tscn",
	"maxCars": 12,
	"isListed": true
}

# Collected Dictionary
const list: Dictionary = {
	"Default_Track": Default_Track,
	"Hungaroring": Hungaroring,
	"Silverstone": Silverstone
}

# Getter functions
static func _get_track_data(trackName: String) -> Dictionary:
	return list.get(trackName)

static func _get_name(trackName: String) -> String:
	return list.get(trackName).get("name")

static func _get_path(trackName: String) -> String:
	return list.get(trackName).get("path")

static func _get_maxCars(trackName: String) -> int:
	return list.get(trackName).get("maxCars")

static func _get_isListed(trackName: String) -> bool:
	return list.get(trackName).get("isListed")

