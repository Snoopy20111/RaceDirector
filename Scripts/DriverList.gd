extends Control
class_name DriverListPanel


# Declare member variables here. Examples:
const driverListItem = preload("res://Scenes/Prefabs/DriverList_Item.tscn")
const placementItem = preload("res://Scenes/Prefabs/DriverList_Placement.tscn")
onready var placementsVBox_ref = $Panel/PlacementsVBox
onready var driversVBox_ref = $Panel/DriversVBox

var placesArray: Array
var driverListItemArray: Array

var counter: float = 0
var updateThreshold = 1


func _process(delta):
	#Every frame, if race is active, refresh driver list every second
	if (GameManager.is_race_active):
		counter += delta
		if (counter >= updateThreshold):
			counter = 0
			update_driver_list()


func init_driver_list(count: int, racerDataArray: Array) -> void:
	
	placesArray.resize(count)
	driverListItemArray.resize(count)
	
	#Add placements equal to total number of cars
	for i in placesArray.size():
		placesArray[i] = placementItem.instance()
		#add as child
		placementsVBox_ref.add_child(placesArray[i])
		#set displayed number (starting from 1st)
		placesArray[i].set_number(i+1)
	
	#For each driver in the list, spawn DriverListItem and give it the corresponding color, name, ID, etc
	for i in driverListItemArray.size():
		driverListItemArray[i] = driverListItem.instance()
		driversVBox_ref.add_child(driverListItemArray[i])
		
		driverListItemArray[i].set_color(racerDataArray[i].car_color)
		driverListItemArray[i].set_name(racerDataArray[i].driver_name)
		driverListItemArray[i].set_carID(racerDataArray[i].carID)


func update_driver_list() -> void:
	#Get the current standings, who's in what order
	#Game Manager will provide a list of sorted IDs, which because the elements
	#in the driverListItemArray are in Car ID order, will line up perfectly
	var list: PoolIntArray = GameManager._get_drivers_ordered()
	var tempArray = driverListItemArray.duplicate()
	
	#sort the nodes in the tree accordingly
	#todo: unpack this more effectively?
	#alternate todo: sort/send the data so we don't have to do this?
	for i in driverListItemArray.size():
		var jValue: int
		for j in tempArray.size():
			if (tempArray[j].carID == list[i]):
				driversVBox_ref.move_child(tempArray[j], i)
				jValue = j
		tempArray.remove(jValue)
	
	#Update the spacing of the numbers accordingly
	update_placement_panels()
	print ("Driver List panel updated!")


func update_placement_panels() -> void:
	for i in driverListItemArray.size():
		var temp = driversVBox_ref.get_child(i) as DriverListItem
		placementsVBox_ref.get_child(i).set_expanded(temp.is_expanded)
