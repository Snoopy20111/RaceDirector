extends Node2D


# Declare member variables here. Examples:
export var minimumSpeed = 100
export var turnDisplayName: String
var turnPrintName: String

signal decelerate(identifier, minimumSpeed)
signal accelerate(identifier)


# Called when the node enters the scene tree for the first time.
func _ready():
	if (turnDisplayName == name or ""):
		turnPrintName = name
	else:
		turnPrintName = turnDisplayName


func _on_Accelerate_area_entered(area):
	if (area.get_parent() is Car):
		var contactedCar = area.get_parent() as Car
		var identifier = contactedCar.carID
		emit_signal("accelerate", identifier)
		print ("Car " + str(identifier) + " accelerating out of " + str(name))


func _on_Decelerate_area_entered(area):
	if (area.get_parent() is Car):
		var contactedCar = area.get_parent() as Car
		var identifier = contactedCar.carID
		emit_signal("decelerate", identifier, minimumSpeed)
		print ("Car " + str(identifier) + " braking into " + str(name))
