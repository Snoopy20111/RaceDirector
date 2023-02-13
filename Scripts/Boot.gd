extends Node2D
class_name Boot

# Debug and starting Options
export var LogoParade: bool = true
export var Fullscreen: bool = false
export var LoadDebugLevel: bool = false
export var DebugWindowSize: bool = false
export var DebugLevelPath: String = "res://Scenes/Tracks/Default_Track.tscn"
export var DebugWindowDimentions: Vector2 = Vector2(1280, 720)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Welcome to Race Director!")
	
	
	if (DebugWindowSize):
		OS.set_window_size(Vector2(DebugWindowDimentions))
	else:
		OS.set_window_fullscreen(Fullscreen)
	
	#initialize audio system
	GameManager._init_FMOD()
	
	randomize()
	
	if (LogoParade):
		SceneManager.change_scene("res://Scenes/UI_Scenes/LogoParade.tscn")
	elif ((LoadDebugLevel) and (DebugLevelPath != null)):
		SceneManager.change_scene(DebugLevelPath)
		
		var trackName = TrackDataMapping._get_trackName_from_path(DebugLevelPath)
		if (trackName != "trackName not found"):
			GameManager._prerace_set_track(trackName)
	else:
		SceneManager.change_scene("res://Scenes/UI_Scenes/MainMenu.tscn")
