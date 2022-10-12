extends PathFollow2D

const myEnums = preload("res://Scripts/myEnums.gd")

# member variables
var speedMPH = 0
var maxSpeed = 240
var speedMult = 6
var currentMinSpeed = 100
var brakingMult = 200
var idleMult = .1
var accelMult = 90
var vOffsetAdder = 0
var vOffsetSpeedMult = 7
var vOffsetMagMult = 7

var accelCurve = preload("res://Curves/Acceleration_Curve.tres")
var brakingCurve = preload("res://Curves/Braking_Curve.tres")

var teamName = "Williams"
var driverFirstName = "Nicholas"
var driverLastName = "GOATifi"
var fadeMode = 0

var willPitNextLap = false
var chanceOfMalfunction = 0.0000
var currentCarState = myEnums.CAR_STATE.RACE_START
var currentDrivingState = myEnums.DRIVING_STATE.IDLING
var currentDriverState =  myEnums.DRIVER_STATE.FOCUSED

signal SpeedUpdate(speed)
signal PittingIntent(pitIntentString)
signal CarState(raceStateString)
signal DrivingState(drivingStateString)
# signal DriverState(driverStateString)

# Called when the node enters the scene tree for the first time.
# func _ready():
# 	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Malfunctions
#	if (randf() < chanceOfMalfunction):
#		print("Malfunction!")
#		currentCarState = myEnums.CAR_STATE.MALFUNCTIONING
#		currentDrivingState = myEnums.DRIVING_STATE.IDLING
	
	# Accelerations
	if (currentCarState == myEnums.CAR_STATE.ON_TRACK):
		match(currentDrivingState):
			myEnums.DRIVING_STATE.ACCELERATING:
				speedMPH += (delta * accelMult * accelCurve.interpolate(speedMPH / maxSpeed))
			myEnums.DRIVING_STATE.BRAKING:
				if (speedMPH >= currentMinSpeed):
					speedMPH -= (delta * brakingMult)
			_:
				pass

	emit_signal("SpeedUpdate", speedMPH)
	offset += (speedMPH * delta * speedMult)
	vOffsetAdder = vOffsetAdder + delta
	v_offset = sin(vOffsetAdder * vOffsetSpeedMult) * vOffsetMagMult * (speedMPH / maxSpeed)
	
	updateUI()


func _on_CallToPit_pressed():
	if (willPitNextLap == true):
		willPitNextLap = false
	elif (willPitNextLap == false):
		willPitNextLap = true
	emit_signal("PittingIntent", willPitNextLap)

func _on_Turn_accelerate():
	currentDrivingState = myEnums.DRIVING_STATE.ACCELERATING
	emit_signal("DrivingState", str(currentDrivingState))

func _on_Turn_decelerate(minimumSpeed):
	currentDrivingState = myEnums.DRIVING_STATE.BRAKING
	currentMinSpeed = minimumSpeed
	emit_signal("DrivingState", str(currentDrivingState))

func _on_Race_Start():
	print("Race Start!")
	currentCarState = myEnums.CAR_STATE.ON_TRACK
	currentDrivingState = myEnums.DRIVING_STATE.ACCELERATING
	emit_signal("CarState", str(currentCarState))
	emit_signal("DrivingState", str(currentDrivingState))

func updateUI():
	pass
