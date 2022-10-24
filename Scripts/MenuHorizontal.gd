extends Control


# Declare member variables here. Examples:
onready var windowWidth: int = get_viewport_rect().size.x
export var extraWidth: int = 50
onready var totalWidth: int = windowWidth + extraWidth

enum MOVEMENT_STATE {LEFT, RIGHT, PAUSE}
var currentMovementState = MOVEMENT_STATE.PAUSE
var transitionDirection = 1
export var animSpeed = 50

onready var Main = $Main
onready var Options = $Options
onready var RaceDetails = $RaceDetails

func _ready():
	# Main.rect_position.x
	Options.rect_position.x = totalWidth
	RaceDetails.rect_position.x = -totalWidth

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Check current viewport size
	windowWidth = get_viewport_rect().size.x
	totalWidth = windowWidth + extraWidth
	Options.rect_position.x = totalWidth
	RaceDetails.rect_position.x = -totalWidth
	
	
	match (currentMovementState):
		MOVEMENT_STATE.PAUSE:
			pass
		MOVEMENT_STATE.LEFT:
			self.rect_position.x -= animSpeed * delta
		MOVEMENT_STATE.RIGHT:
			self.rect_position.x += animSpeed * delta
	
	
