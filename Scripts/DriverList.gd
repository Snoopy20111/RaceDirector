extends Control


# Declare member variables here. Examples:
const driverListItem = preload("res://Scenes/Prefabs/DriverListItem.tscn")
const placementItem = preload("res://Scenes/Prefabs/Placements.tscn")
onready var placementsVBox_ref = $Panel/PlacementsVBox
onready var driversVBox_ref = $Panel/DriversVBox

var placesArray: Array
var driverListItemArray: Array


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func init_driver_list(count: int, color: PoolColorArray):
	
	placesArray.resize(count)
	driverListItemArray.resize(count)
	
	#Add placements equal to total number of cars
	for i in placesArray.size():
		placesArray[i] = placementItem.instance()
		#add as child
		placementsVBox_ref.add_child(placesArray[i])
		#set number (dependent on ready function info)
		placesArray[i].set_number(i+1)
	
	#For each driver in the list, spawn DriverListItem and give it the corresponding color, name, etc
	for i in driverListItemArray.size():
		driverListItemArray[i] = driverListItem.instance()
		driversVBox_ref.add_child(driverListItemArray[i])
		
		driverListItemArray[i].set_color(color[i])
