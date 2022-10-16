extends ColorRect


# Size in pixels / units to go over the window size
export var bleed_size: int = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	resize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	resize()


func resize():
	var viewport_size = get_viewport_rect().size
	rect_size = viewport_size + Vector2(bleed_size,bleed_size)
