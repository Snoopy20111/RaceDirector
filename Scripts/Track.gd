extends Node2D


var carScene = preload("res://Scenes/Prefabs/Car.tscn")

var carRef: Array

onready var trackRef = $Track
onready var pitLaneRef = $PitLane
onready var pitEntranceRef = $PitLane/PitEntrance
onready var pitExitRef = $PitLane/PitExit
onready var driverListRef = $InRaceHUD/DriverList
#onready var flag_panel_ref = $InRaceHUD/VBoxContainer/FlagPanel
onready var race_timer_ref = $InRaceHUD/VBoxContainer/RaceTimer

var pitBox: Array
var pitBox_id: Array

# rejoin at closest offset to the last point of the pit lane
onready var rejoinPoint: float = trackRef.curve.get_closest_offset(pitLaneRef.curve.get_point_position(pitLaneRef.curve.get_point_count() - 1))

var isPitOpen: bool = true
var isPitExitOpen: bool = true

var gridPosition: Array
var gridPositionOffset: float = 75
var gridPositionStartOffset: float = 75


func _ready():
	#connect to Game Manager events
# warning-ignore:return_value_discarded
	GameManager.connect("race_started", self, "_on_Race_Start")
# warning-ignore:return_value_discarded
	GameManager.connect("race_ended", self, "_on_Race_End")
	
	gridPosition.resize(TrackDataMapping._get_maxCars(GameManager.currentRaceOptions.get("track")))
	for i in gridPosition.size():
		gridPosition[i] = -gridPositionStartOffset + (-i * gridPositionOffset)
	
	# Get the Game Manager to make the racer list
	GameManager._generate_racer_data()
	
	#Instantiate number of cars, each carying a unique ID
	carRef.resize(GameManager.racerDataArray.size())
	#print("Number of Cars: " + String(carRef.size()))
	
	#Assign Cars
	for i in carRef.size():
		carRef[i] = carScene.instance()
		carRef[i]._init_car(i, GameManager.racerDataArray[i].car_color)
		trackRef.add_child(carRef[i])
		carRef[i].offset = gridPosition[i]
	
	#Set up the list on the UI panel
	driverListRef.init_driver_list(GameManager.racerDataArray.size(), GameManager.racerDataArray)
	
	#print ("Pit Box ID array size: " + String(pitBox_id.size()))
	
	#assign colors to pit boxes
	#for each car we're starting with
	for i in carRef.size():
		#go through the pitBox ID list
		for j in pitBox_id.size():
			#and if it's i (our driver ID), assign the corresponding car color
			if (pitBox_id[j] == i + 1):
				pitBox[j]._set_pitbox_color(GameManager.racerDataArray[i].car_color)
				break

func _register_PitBox(pitboxRef: PitBox, pitBoxID: int) -> void:
	pitBox.append(pitboxRef)
	pitBox_id.append(pitBoxID)

func _on_PitEntrance_area_entered(area):
	var tempCar = area.get_parent() as Car
	var carID: int = tempCar.carID
	
	if ((carRef[carID].willPitNextLap) and (carRef[carID].currentCarState == Enums.CAR_STATE.ON_TRACK) and (isPitOpen)):
		carRef[carID].currentCarState = Enums.CAR_STATE.PITTING
		carRef[carID].willPitNextLap = false
		carRef[carID].emit_signal("PittingIntent", false, carID)
		carRef[carID].offset = 0
		
		reparent(carRef[carID], pitLaneRef)

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

func _on_Pitbox_area_entered(area, pitBoxID):
	if (area.get_parent().get_class() == "Car"):
		var tempCar = area.get_parent() as Car
		var carID: int = tempCar.carID
		if (carRef[carID].currentCarState == Enums.CAR_STATE.PITTING) && (carID == pitBoxID):
			carRef[carID].currentCarState = Enums.CAR_STATE.IN_PITBOX
			yield(get_tree().create_timer(rand_range(4.0, 8.0)), "timeout")
			carRef[carID].currentCarState = Enums.CAR_STATE.PITTING

func _on_FinishLine_area_entered(area):
	#print ("parent type of area entered: " + String(area.get_parent().get_class()))
	if (area.get_parent().get_class() == "Car"):
		var tempCar = area.get_parent() as Car
		print ("Car " + String(tempCar.carID) + " crossed the line!")
		GameManager._race_car_lap_completed(tempCar.carID)


func _on_Race_Start():
	# For each active car, set to accelerating
	for i in carRef.size():
		carRef[i]._on_Race_Start()
	# And change the flag to Green

func _on_Race_End():
	pass

########### Utility Functions ###########

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
