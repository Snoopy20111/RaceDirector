extends Reference
class_name RacerData


# Declare member variables here. Examples:
var carID: int
var driver_name: String = "Firstname Lastname"
var car_color: Color = Color.black
var current_driver_state =  Enums.DRIVER_STATE.FOCUSED

# Race-specific info
var current_lap: int = 0
var fastest_lap: float

func init_racer_data(newCarID: int):
	carID = newCarID

func reset_color() -> void:
	car_color = Color.black

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
