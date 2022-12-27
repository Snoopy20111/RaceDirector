extends Control


# Declare member variables here. Examples:
const driverListItem = preload("res://Scenes/Prefabs/DriverListItem.tscn")
const placementItem = preload("res://Scenes/Prefabs/Placements.tscn")
onready var placementsVBox_ref = $Panel/PlacementsVBox
onready var driversVBox_ref = $Panel/DriversVBox

var placesArray: Array
var driverListItemArray: Array

func init_driver_list(count: int, racerDataArray: Array):
	
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
		
		driverListItemArray[i].set_color(racerDataArray[i].car_color)

func update_driver_list():
	#get the current standings, who's in what order
	#sort the nodes in the tree accordingly
	#update the spacing of the numbers accordingly
	
	#this will rely a lot on the move_child function
	#from the Node class!
	pass
