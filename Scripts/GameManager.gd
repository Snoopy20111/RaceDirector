extends Node2D


# Debug Options
export var LogoParade = true

# Scenes
const LogoParadeResource = preload("res://Scenes/LogoParade.tscn")
var LogoParadeInstance

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Welcome to Race Director!")
	
	# Load the Scene Manager and connect relevant signals
	
	# Logo Parade, if variable is on
	print("Logo Parade: " + str(LogoParade))
	if (LogoParade == true):
		SceneManager.fade_in( { "speed": 5, "pattern": "scribbles"} )
		#SceneManagerInstance.fade_in({ "pattern": "scribbles", "speed": 4})
		LogoParadeInstance = LogoParadeResource.instance()
		LogoParadeInstance.name = "LogoParade"
		self.add_child(LogoParadeInstance)
		
		LogoParadeInstance.get_node("LogoParade").connect("LogoParade_Death", self, "_on_LogoParade_Death")
	else:
		SceneManager.change_scene("res://Scenes/Tracks/StartYourEngines.tscn")
		pass
	
func _on_LogoParade_Death():
	# Move to the main menu, or in this test mode, to Start Your Engines
	SceneManager.change_scene("res://Scenes/Tracks/StartYourEngines.tscn")
	
	# Once the next scene is loaded, unload the Logo Parade scene
	yield(SceneManager, "scene_loaded")
	print("Scene Loaded")
	LogoParadeInstance.queue_free()
