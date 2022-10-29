extends Button


# Declare member variables here. Examples:
export var QuitOptions: Dictionary = {
	"speed": 2.0,
	"color": Color("#000000"),
	"pattern": "fade",
	"ease": 1.0,
}
export var timeAfterFade: float = 0.075

func _pressed():
	yield (SceneManager.fade_out(QuitOptions), "completed")
	yield(get_tree().create_timer(timeAfterFade), "timeout")
	get_tree().quit()
