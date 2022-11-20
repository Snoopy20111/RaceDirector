extends Path2D

var carScene = preload("res://Scenes/Prefabs/Car.tscn")

var carRef: Array
onready var pitLaneRef = $PitLane
onready var pitEntranceRef = $PitLane/PitEntrance
onready var pitExitRef = $PitLane/PitExit

# rejoin at closest offset to the last point of the pit lane
onready var rejoinPoint: float = self.curve.get_closest_offset(pitLaneRef.curve.get_point_position(pitLaneRef.curve.get_point_count() - 1))

var isPitOpen: bool = true
var isPitExitOpen: bool = true
export var trackNameString: String

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
	
	var carColors: PoolColorArray; carColors.resize(carRef.size())
	var possibleCarColors: Array; possibleCarColors.resize(255)
	var hueRadius = 10
	for i in possibleCarColors.size():
		possibleCarColors[i] = i
	
	for i in carRef.size():
		carRef[i] = carScene.instance()
		
		#generate custom colors with random Hue and random in range saturation
		# and brightness, with no duplicates
		var tempRand := randi() % possibleCarColors.size()
		print("tempRand Cell: " + String(tempRand) + " and tempRand Value: " + String(possibleCarColors[tempRand]))
		carColors[i] = Color.from_hsv(float(possibleCarColors[tempRand]) / 255, 1, rand_range(0.6, .9))
		print("Car Color: " + String(carColors[i]))
		
		carRef[i]._init_car(i, carColors[i])
		add_child(carRef[i])
		carRef[i].offset = gridPosition[i]
		
		#remove used color(s) from pool by slicing and splicing the given range out
		var tempRandLocation := possibleCarColors.find(tempRand)
		var lowerSlice: Array
		var upperSlice: Array
		
		if (tempRandLocation >= hueRadius):
			lowerSlice = possibleCarColors.slice(0, tempRandLocation - hueRadius, 1, false)
		if ((tempRandLocation + hueRadius) < possibleCarColors.size()):
			upperSlice = possibleCarColors.slice(tempRandLocation + hueRadius, possibleCarColors.size(), 1, false)
			
		lowerSlice.append_array(upperSlice)
		possibleCarColors = lowerSlice


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


func _on_Race_Start():
	# For each active car, set to accelerating
	for i in carRef.size():
		carRef[i]._on_Race_Start()


func on_turn_decelerate(identifier, minimumSpeed):
	carRef[identifier]._on_Turn_decelerate(minimumSpeed)

func on_turn_accelerate(identifier):
	carRef[identifier]._on_Turn_accelerate()


########### Utility Functions ###########

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
