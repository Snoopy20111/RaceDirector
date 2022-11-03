extends Path2D

var carScene = preload("res://Scenes/Prefabs/Car.tscn")

var carRef: Array
onready var pitLaneRef = $PitLane
onready var pitEntranceRef = $PitLane/PitEntrance
onready var pitExitRef = $PitLane/PitExit
var rejoinPoint

var isPitOpen: bool = true
var isPitExitOpen: bool = true

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#Instantiate number of cars, each carying a unique ID
	carRef.resize(GameManager.currentRaceOptions.get("carCount"))
	for i in carRef.size():
		carRef[i] = carScene.instance()
		carRef[i]._init_car(i)
		add_child(carRef[i])
		
	
	# unholy calculation to get the offset of the last point on the Pit Lane
	rejoinPoint = self.curve.get_closest_offset(pitLaneRef.curve.get_point_position(pitLaneRef.curve.get_point_count() - 1))


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
		reparent(carRef[carID], self)
		carRef[carID].offset = rejoinPoint


########### Utility Functions ###########

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
