extends Control


# Declare member variables here. Examples:
onready var parentNode = get_parent()
var startingRotation: float = 90


# Called when the node enters the scene tree for the first time.
func _ready():
	pointNorth()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pointNorth()

func pointNorth():
	self.rect_rotation = (-1 * parentNode.rotation) + startingRotation
	print (rect_rotation)
