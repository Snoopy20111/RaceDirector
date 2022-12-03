extends Control


# Declare member variables here. Examples:
const driverListItem = preload("res://Scenes/Prefabs/DriverListItem.tscn")
const placementItem = preload("res://Scenes/Prefabs/Placements.tscn")
onready var backPanel = $Panel/ReferenceRect

var placesArray: Array
var placementLocations: PoolIntArray
var driverListItemArray: Array
var placementSpace = 60
var iconRightSpacing = 50


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init_driver_list(count: int, color: PoolColorArray):
	
	placementLocations.resize(count)
	placesArray.resize(count)
	driverListItemArray.resize(count)
	
	for i in placementLocations.size():
		placementLocations[i] = i * placementSpace
	
	#Add placements equal to total number of cars
	for i in placesArray.size():
		placesArray[i] = placementItem.instance()
		#place in proper locations
		placesArray[i].rect_position.y = placementLocations[i]
		#set number
		#todo
		#add as child
		backPanel.add_child(placesArray[i])
	
	#For each driver in the list, spawn DriverListItem and give it the corresponding color, name, etc
	for i in driverListItemArray.size():
		driverListItemArray[i] = driverListItem.instance()
		#place in proper locations
		driverListItemArray[i].rect_position.x = iconRightSpacing
		driverListItemArray[i].rect_position.y = placementLocations[i]
		
		backPanel.add_child(driverListItemArray[i])
		driverListItemArray[i].set_color(color[i])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
