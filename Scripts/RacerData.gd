extends Reference
class_name RacerData


var carID: int
var driver_name: String = "NameNotSet_RacerData"
var driver_nationality: String = "NoNationality_RacerData"
var car_color: Color = Color.black
var current_driver_state =  Enums.DRIVER_STATE.FOCUSED

# Race-specific info
var current_lap: int = 0
var current_lap_progress: float = 0.0
var lap_times_array: PoolRealArray
var fastest_lap: float

func init_racer_data(newCarID: int):
	carID = newCarID

func reset_color() -> void:
	car_color = Color.black

# Called when the node enters the scene tree for the first time.
func _ready():
	lap_times_array.resize(0)
	driver_name = driver_name + " " + String(carID)
