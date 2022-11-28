extends ItemList


# Member variables
const driverListItem = preload("res://Scenes/Prefabs/DriverListItem.tscn")

var listItemRef: Array


# Called when the node enters the scene tree for the first time.
func _ready():
	# For each driver, instantiate a "Driver List Item"
	listItemRef.resize(GameManager.currentRaceOptions.get("carCount"))
	for i in listItemRef.size():
		listItemRef[i] = driverListItem.instance()
		add_child(listItemRef[i])
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
