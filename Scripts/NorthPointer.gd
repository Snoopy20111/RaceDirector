extends Node2D


var parentNode


# Called when the node enters the scene tree for the first time.
func _ready():
	parentNode = get_parent()
	pointNorth()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pointNorth()

func pointNorth():
	rotation = parentNode.rotation * -1
	pass
