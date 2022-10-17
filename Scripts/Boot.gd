extends Node2D

# Debug Options
export var LogoParade = true
export var LoadDebugLevel = false

export var DebugLevel: Resource
export var DebugLevelPath: String = "res://Scenes/Tracks/StartYourEngines.tscn"

# Signals
# signal GameLoaded

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Welcome to Race Director!")
	
	GameManager._init_FMOD()
	
	if (LogoParade):
		SceneManager.change_scene("res://Scenes/UI_Scenes/LogoParade.tscn")
	elif (LoadDebugLevel):
		if (DebugLevel != null):
			SceneManager.change_scene(DebugLevel)
		elif (DebugLevelPath != null):
			SceneManager.change_scene(DebugLevelPath)
	else:
		SceneManager.change_scene("res://Scenes/Tracks/MainMenu.tscn")
