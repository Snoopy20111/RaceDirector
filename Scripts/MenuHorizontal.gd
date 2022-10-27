extends Control


# Declare member variables here. Examples:
onready var windowWidth: float = get_viewport_rect().size.x
export var extraWidth: int = 50
onready var totalWidth: int = windowWidth + extraWidth
export var animSpeed: float = 1.0
const AnimCurve = preload("res://Curves/MainMenu_Anim_Curve.tres")
var lockThreshold: float = 30
var tempLocation: int = 0

enum MOVEMENT_STATE {LEFT, RIGHT, PAUSE}
var currentMovementState = MOVEMENT_STATE.PAUSE

var targetNodeGroup
onready var Main:= $Main
var mainLocation: float = 0
onready var Options:= $Options
onready var optionsLocation: float = totalWidth
onready var RaceDetails:= $RaceDetails
onready var raceDetailsLocation: float = -totalWidth

onready var canStopInCenterTimer:= $CanStopInCenterTimer
var canStopInCenter: bool = false

func _ready():
	#Place Options and RaceDetails to the right and left respectively
	set_positions()
	
	#Attach the viewport resized event to function viewport_resized()
# warning-ignore:return_value_discarded
	get_tree().get_root().connect("size_changed", self, "viewport_resized")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match (currentMovementState):
		MOVEMENT_STATE.LEFT:
			if (self.rect_position.x > totalWidth):
				currentMovementState = MOVEMENT_STATE.PAUSE
				self.rect_position.x = totalWidth
			elif ((self.rect_position.x < lockThreshold) and (self.rect_position.x > -lockThreshold) and (canStopInCenter == true)):
				currentMovementState = MOVEMENT_STATE.PAUSE
				self.rect_position.x = 0
				canStopInCenter = false
			else:
				var temp:= abs(tempLocation - self.rect_position.x) / totalWidth
				self.rect_position.x += animSpeed * delta * totalWidth * AnimCurve.interpolate(temp)
				print(temp)
				
		MOVEMENT_STATE.RIGHT:
			if (self.rect_position.x < -totalWidth):
				currentMovementState = MOVEMENT_STATE.PAUSE
				self.rect_position.x = -totalWidth
			elif ((self.rect_position.x < lockThreshold) and (self.rect_position.x > -lockThreshold) and (canStopInCenter == true)):
				currentMovementState = MOVEMENT_STATE.PAUSE
				self.rect_position.x = 0
				canStopInCenter = false
			else:
				var temp:= abs(tempLocation - self.rect_position.x) / totalWidth
				self.rect_position.x -= animSpeed * delta * totalWidth * AnimCurve.interpolate(temp)
				print(temp)


func canStopInCenterTimer_ended():
	canStopInCenter = true

func set_positions():
	Main.rect_position.x = mainLocation
	Options.rect_position.x = optionsLocation
	RaceDetails.rect_position.x = raceDetailsLocation

func viewport_resized():
	windowWidth = get_viewport_rect().size.x
# warning-ignore:narrowing_conversion
	totalWidth = windowWidth + extraWidth
	optionsLocation = totalWidth
	raceDetailsLocation = -totalWidth
	set_positions()
	print(windowWidth)

func move_left():
	currentMovementState = MOVEMENT_STATE.LEFT
	tempLocation = self.rect_position.x
	canStopInCenter = false
	canStopInCenterTimer.start()

func move_right():
	currentMovementState = MOVEMENT_STATE.RIGHT
	tempLocation = self.rect_position.x
	canStopInCenter = false
	canStopInCenterTimer.start()
