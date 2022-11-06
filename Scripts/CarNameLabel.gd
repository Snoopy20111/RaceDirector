extends ColorRect


# Declare member variables here. Examples:
var isCarMoused: bool
var isSelfMoused: bool

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if isCarMoused or (isSelfMoused and visible == false):
		visible = true
	else:
		visible = false



func _mouse_Entered():
	isSelfMoused = true
	
func _mouse_Exited():
	isSelfMoused = false

func _on_MouseDetector_mouse_entered():
	isCarMoused = true

func _on_MouseDetector_mouse_exited():
	isCarMoused = false
