extends Button


# Declare member variables here. Examples:
export var SceneString: String = "res://Scenes/Tracks/StartYourEngines.tscn"
export var SharedEasing: bool = true
export var SharedAnimName: bool = true
export var SceneLoadOptions: Dictionary = {
	"speed": 2,
	"color": Color("#000000"),
	"pattern": "fade",
	"wait_time": 0.5,
	"invert": false,
	"invert_on_leave": true,
	"ease": 1.0,
	"ease_leave": 1.0,
	"ease_enter": 1.0,
	"skip_scene_change": false,
	"skip_fade_out": false,
	"skip_fade_in": false,
	"animation_name": null,
	"animation_name_enter": null,
	"animation_name_leave": null
}

export var hovered_FMOD_path: String = "event:/UI/Nav_Mouseover"
export var unhovered_FMOD_path: String = ""
export var pressed_FMOD_path: String = "event:/UI/Nav_Accept"

onready var TrimmedLoadOptions = SceneLoadOptions


func _ready():
	if (SharedEasing == true):
		TrimmedLoadOptions.erase("ease_leave")
		TrimmedLoadOptions.erase("ease_enter")
	else:
		TrimmedLoadOptions.erase("ease")
	
	if (SharedAnimName == true):
		TrimmedLoadOptions.erase("animation_name_enter")
		TrimmedLoadOptions.erase("animation_name_leave")
	else:
		TrimmedLoadOptions.erase("animation_name")
		
	self.connect("pressed", self, "onPressed")
	self.connect("mouse_entered", self, "onHovered")
	self.connect("mouse_exited", self, "onUnhovered")


func _pressed():
	SceneManager.change_scene(SceneString, TrimmedLoadOptions)
	if (Fmod.check_event_path(pressed_FMOD_path)):
		Fmod.play_one_shot(pressed_FMOD_path, self)

func onHovered():
	if (Fmod.check_event_path(hovered_FMOD_path)):
		Fmod.play_one_shot(hovered_FMOD_path, self)

func onUnhovered():
	if (Fmod.check_event_path(unhovered_FMOD_path)):
		Fmod.play_one_shot(unhovered_FMOD_path, self)
