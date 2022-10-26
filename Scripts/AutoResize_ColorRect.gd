extends ColorRect


# Size in pixels / units to go over the window size
export var bleed_size: int = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().get_root().connect("size_changed", self, "viewport_resized")

func viewport_resized():
	var viewport_size = get_viewport_rect().size
	rect_size = viewport_size + Vector2(bleed_size,bleed_size)
