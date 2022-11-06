extends Node2D


# Declare member variables here. Examples:
export var minimumSpeed = 100
signal decelerate(identifier, minimumSpeed)
signal accelerate(identifier)

# Called when the node enters the scene tree for the first time.
# func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Accelerate_area_entered(area):
	var contactedCar = area.get_parent() as Car
	var identifier = contactedCar.carID
	emit_signal("accelerate", identifier)
	print ("Car " + identifier + " accelerating out of Turn " + str(name))


func _on_Decelerate_area_entered(area):
	var contactedCar = area.get_parent() as Car
	var identifier = contactedCar.carID
	emit_signal("decelerate", identifier, minimumSpeed)
	print ("Car " + identifier + " braking into Turn " + str(name))
