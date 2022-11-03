extends Node2D

# Debug Options
export var LogoParade: bool = true
export var LoadDebugLevel: bool = false
export var DebugWindowSize: bool = false
export var DebugLevelPath: String = "res://Scenes/Tracks/StartYourEngines.tscn"
export var DebugWindowDimentions: Vector2 = Vector2(1280, 720)

# Signals
# signal GameLoaded

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Welcome to Race Director!")
	
	if (DebugWindowSize):
		OS.set_window_size(Vector2(DebugWindowDimentions))
	
	GameManager._init_FMOD()
	
	if (LogoParade):
		SceneManager.change_scene("res://Scenes/UI_Scenes/LogoParade.tscn")
	elif (LoadDebugLevel):
		if (DebugLevelPath != null):
			SceneManager.change_scene(DebugLevelPath)
	else:
		SceneManager.change_scene("res://Scenes/UI_Scenes/MainMenu.tscn")
