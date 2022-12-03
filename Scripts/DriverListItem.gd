extends HBoxContainer


onready var colorRectRef = $ColorRect


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_color(newColor: Color):
	colorRectRef.color = newColor
