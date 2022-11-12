extends Button

# Declare member variables here. Examples:
export var hovered_FMOD_path: String = "event:/UI/Nav_Mouseover"
export var unhovered_FMOD_path: String = ""
export var pressed_FMOD_path: String = "event:/UI/Nav_Accept"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", self, "onPressed")
	self.connect("mouse_entered", self, "onHovered")
	self.connect("mouse_exited", self, "onUnhovered")


func onPressed():
	Fmod.play_one_shot(pressed_FMOD_path, self)

func onHovered():
	Fmod.play_one_shot(hovered_FMOD_path, self)

func onUnhovered():
	Fmod.play_one_shot(unhovered_FMOD_path, self)
