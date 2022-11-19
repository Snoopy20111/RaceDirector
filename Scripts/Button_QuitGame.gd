extends Button


# Declare member variables here. Examples:
export var QuitOptions: Dictionary = {
	"speed": 2.0,
	"color": Color("#000000"),
	"pattern": "fade",
	"ease": 1.0,
}
export var timeAfterFade: float = 0.075

export var hovered_FMOD_path: String = "event:/UI/Nav_Mouseover"
export var unhovered_FMOD_path: String = ""
export var pressed_FMOD_path: String = "event:/UI/Nav_Accept"
	

# Called when the node enters the scene tree for the first time.
func _ready():
	self.connect("pressed", self, "onPressed")
	self.connect("mouse_entered", self, "onHovered")
	self.connect("mouse_exited", self, "onUnhovered")


func onHovered():
	if (Fmod.check_event_path(hovered_FMOD_path)):
		Fmod.play_one_shot(hovered_FMOD_path, self)

func onUnhovered():
	if (Fmod.check_event_path(unhovered_FMOD_path)):
		Fmod.play_one_shot(unhovered_FMOD_path, self)


func _pressed():
	if (Fmod.check_event_path(pressed_FMOD_path)):
		Fmod.play_one_shot(pressed_FMOD_path, self)
	
	yield (SceneManager.fade_out(QuitOptions), "completed")
	yield(get_tree().create_timer(timeAfterFade), "timeout")
	get_tree().quit()

