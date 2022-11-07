extends Reference
class_name TrackDataMapping

# Individual Tracks
const Default_Track: Dictionary = {
	"display_name": "Default_Track",
	"path": "res://Scenes/Tracks/Default_Track.tscn",
	"maxCars": 6,
	"isListed": false
}
const Hungaroring: Dictionary = {
	"display_name": "Hungaroring",
	"path": "res://Scenes/Tracks/Default_Track.tscn",
	"maxCars": 12,
	"isListed": true
}
const Silverstone: Dictionary = {
	"display_name": "Silverstone",
	"path": "res://Scenes/Tracks/Default_Track.tscn",
	"maxCars": 8,
	"isListed": true
}

# Collected Dictionary
const full_list: Dictionary = {
	"Default_Track": Default_Track,
	"Hungaroring": Hungaroring,
	"Silverstone": Silverstone
}

# Getter functions
static func _get_track_data(trackName: String) -> Dictionary:
	return full_list.get(trackName)

static func _get_name(trackName: String) -> String:
	return full_list.get(trackName).get("display_name")

static func _get_path(trackName: String) -> String:
	return full_list.get(trackName).get("path")

static func _get_maxCars(trackName: String) -> int:
	return full_list.get(trackName).get("maxCars")

static func _get_isListed(trackName: String) -> bool:
	return full_list.get(trackName).get("isListed")

static func _get_playable_list() -> Array:
	var clean_list := full_list
	var clean_array := clean_list.keys()
	for i in clean_array:
		#filter out the ones we don't want
		if (!clean_list[i]["isListed"]):
# warning-ignore:return_value_discarded
			clean_list.erase(i)
	return clean_list.keys()

static func _get_trackName_from_path(path: String) -> String:
	var returnVal: String
	for i in full_list:
		if (path == full_list[i].path):
			returnVal = full_list[i].display_name
	if (returnVal != "" or null):
		return returnVal
	else:
		return "trackName not found"
