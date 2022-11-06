extends PathFollow2D
class_name Car

# member variables
var carID: int

var speedMPH: float = 0
var maxSpeed: float = 240
var speedMult: float = 6
var currentMinSpeed: float = 100
var brakingMult: float = 200
var idleMult: float = .1
var accelMult: float = 90
var vOffsetAdder: float = 0
var vOffsetSpeedMult: float = 7
var vOffsetMagMult: float = 7

var accelCurve = preload("res://Curves/Acceleration_Curve.tres")
var brakingCurve = preload("res://Curves/Braking_Curve.tres")

var teamName: String = "Williams"
var driverFirstName: String = "Nicholas"
var driverLastName: String = "GOATifi"

var willPitNextLap = false
var chanceOfMalfunction = 0.0000
var currentCarState: int = Enums.CAR_STATE.RACE_START
var currentDrivingState: int = Enums.DRIVING_STATE.IDLING
var currentDriverState =  Enums.DRIVER_STATE.FOCUSED

signal SpeedUpdate(speed)
signal PittingIntent(pitIntentString)
signal CarState(raceStateString)
signal DrivingState(drivingStateString)

# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass

func _init_car(newID: int):
	carID = newID
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Malfunctions
#	if (randf() < chanceOfMalfunction):
#		print("Malfunction!")
#		currentCarState = RaceEnums.CAR_STATE.MALFUNCTIONING
#		currentDrivingState = RaceEnums.DRIVING_STATE.IDLING
	
	# Accelerations
	if (currentCarState == Enums.CAR_STATE.ON_TRACK):
		match(currentDrivingState):
			Enums.DRIVING_STATE.ACCELERATING:
				speedMPH += (delta * accelMult * accelCurve.interpolate(speedMPH / maxSpeed))
			Enums.DRIVING_STATE.BRAKING:
				if (speedMPH >= currentMinSpeed):
					speedMPH -= (delta * brakingMult)
			_:
				pass

	emit_signal("SpeedUpdate", speedMPH)
	offset += (speedMPH * delta * speedMult)
	vOffsetAdder = vOffsetAdder + delta
	v_offset = sin(vOffsetAdder * vOffsetSpeedMult) * vOffsetMagMult * (speedMPH / maxSpeed)


func _on_CallToPit_pressed():
	if (willPitNextLap == true):
		willPitNextLap = false
	elif (willPitNextLap == false):
		willPitNextLap = true
	emit_signal("PittingIntent", willPitNextLap)

func _on_Turn_accelerate():
	currentDrivingState = Enums.DRIVING_STATE.ACCELERATING
	emit_signal("DrivingState", str(currentDrivingState))

func _on_Turn_decelerate(minimumSpeed):
	currentDrivingState = Enums.DRIVING_STATE.BRAKING
	currentMinSpeed = minimumSpeed
	emit_signal("DrivingState", str(currentDrivingState))

func _on_Race_Start():
	currentCarState = Enums.CAR_STATE.ON_TRACK
	currentDrivingState = Enums.DRIVING_STATE.ACCELERATING
	emit_signal("CarState", str(currentCarState))
	emit_signal("DrivingState", str(currentDrivingState))
