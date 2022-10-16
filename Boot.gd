extends Node2D

# Debug Options
export var LogoParade = true

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Welcome to Race Director!")
	
	GameManager._init_FMOD()

