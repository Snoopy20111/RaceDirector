extends Node2D


# Declare member variables here. Examples:
export var minimumSpeed = 100
signal decelerate(minimumSpeed)
signal accelerate()

# Called when the node enters the scene tree for the first time.
# func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Accelerate_area_entered(_area):
	emit_signal("accelerate")
	var tempString01 = str(name)
	var tempString02 = ": accelerate"
	print (tempString01 + tempString02)


func _on_Decelerate_area_entered(_area):
	emit_signal("decelerate", minimumSpeed)
	var tempString01 = str(name)
	var tempString02 = ": BRAKE"
	print (tempString01 + tempString02)
