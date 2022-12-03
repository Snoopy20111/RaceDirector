extends Node2D


var carScene = preload("res://Scenes/Prefabs/Car.tscn")

var carRef: Array

onready var trackRef = $Track
onready var pitLaneRef = $Track/PitLane
onready var pitEntranceRef = $Track/PitLane/PitEntrance
onready var pitExitRef = $Track/PitLane/PitExit
onready var driverListRef = $InRaceHUD/DriverList

# rejoin at closest offset to the last point of the pit lane
onready var rejoinPoint: float = trackRef.curve.get_closest_offset(pitLaneRef.curve.get_point_position(pitLaneRef.curve.get_point_count() - 1))

var isPitOpen: bool = true
var isPitExitOpen: bool = true

var gridPosition: Array
var gridPositionOffset: float = 75
var gridPositionStartOffset: float = 30


func _ready():
	
	gridPosition.resize(TrackDataMapping._get_maxCars(GameManager.currentRaceOptions.get("track")))
	for i in gridPosition.size():
		gridPosition[i] = -i * gridPositionOffset
	
	#Instantiate number of cars, each carying a unique ID
	carRef.resize(GameManager.currentRaceOptions.get("carCount"))
	print("Number of Cars: " + String(GameManager.currentRaceOptions.get("carCount")))
	GameManager._generate_car_colors()
	GameManager._generate_driver_names()
	
	#Assign Cars
	for i in carRef.size():
		carRef[i] = carScene.instance()
		carRef[i]._init_car(i, GameManager.carColors[i])
		trackRef.add_child(carRef[i])
		carRef[i].offset = gridPosition[i]
	
	driverListRef.init_driver_list(carRef.size(), GameManager.carColors)


func _on_PitEntrance_area_entered(area):
	var tempCar = area.get_parent() as Car
	var carID: int = tempCar.carID
	
	if ((carRef[carID].willPitNextLap) and (carRef[carID].currentCarState == Enums.CAR_STATE.ON_TRACK) and (isPitOpen)):
		carRef[carID].currentCarState = Enums.CAR_STATE.PITTING
		carRef[carID].willPitNextLap = false
		carRef[carID].emit_signal("PittingIntent", false, carID)
		carRef[carID].offset = 0
		
		reparent(carRef[carID], $PitLane)


func _on_PitExit_area_entered(area):
	var tempCar = area.get_parent() as Car
	var carID: int = tempCar.carID
	if ((carRef[carID].currentCarState == Enums.CAR_STATE.PITTING) and isPitExitOpen):
		carRef[carID].currentCarState = Enums.CAR_STATE.ON_TRACK
		reparent(carRef[carID], trackRef)
		carRef[carID].offset = rejoinPoint


func _on_turn_accelerate(identifier):
	carRef[identifier]._on_Turn_accelerate()


func _on_turn_decelerate(identifier, minimumSpeed):
	carRef[identifier]._on_Turn_decelerate(minimumSpeed)


func _on_FinishLine_area_entered(area):
	var tempCar = area.get_parent() as Car
	var carID: int = tempCar.carID


func _on_Race_Start():
	# For each active car, set to accelerating
	for i in carRef.size():
		carRef[i]._on_Race_Start()

########### Utility Functions ###########

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)

