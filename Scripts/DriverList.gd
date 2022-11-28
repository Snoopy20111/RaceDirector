extends Control


# Declare member variables here. Examples:
const driverListItem = preload("res://Scenes/Prefabs/DriverListItem.tscn")
const placementItem = preload("res://Scenes/Prefabs/Placements.tscn")
onready var backPanel = $Panel

var placesArray: Array
var placementLocations: Array
var driverListItemArray: Array
var placementSpace = 120
var iconRightSpacing = 30


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.

func init_driver_list(count: int, color: PoolColorArray):
	
	placesArray.resize(count)
	#Add placements equal to total number of cars
	for i in placesArray:
		placesArray[i] = placementItem.instance()
		#set number
		#todo
		#add as child
		add_child(placesArray[i])
	
	#For each driver in the list, spawn DriverListItem and give it the corresponding color, name, etc
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
