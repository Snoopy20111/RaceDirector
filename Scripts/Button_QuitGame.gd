extends Button


# Declare member variables here. Examples:
export var QuitOptions: Dictionary = {
	"speed": 2,
	"color": Color("#000000"),
	"pattern": "fade",
	"ease": 1.0,
}

func _pressed():
	yield (SceneManager.fade_out(QuitOptions), "completed")
	get_tree().quit()
