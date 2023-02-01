extends MarginContainer


# Declare member variables here. Examples:
var race_results_item: Array
var race_results_item_scene = preload("res://Scenes/Prefabs/RaceResults_Item.tscn")


onready var race_results_grid_ref = $ScrollContainer/PanelContainer/RaceResults_Grid



# Called when the node enters the scene tree for the first time.
func _ready():
	var racer_data_array = GameManager.racerDataArray
	var racer_standing_array: PoolIntArray = GameManager.racerStandingArray
	var racer_array_size: int = racer_standing_array.size()
	
	
#var carID: int
#var driver_name: String = "NameNotSet_RacerData"
#var driver_nationality: String = "NoNationality_RacerData"
#var car_color: Color = Color.black
#var current_driver_state =  Enums.DRIVER_STATE.FOCUSED
#var current_lap: int = 0
#var current_lap_progress: float = 0.0
#var lap_times_array: PoolRealArray
#var fastest_lap: float
#var has_completed_race: bool = false
	
	
	#add the necessary items in order of their finishing placement
	race_results_item.resize(racer_array_size)
	for i in racer_array_size:
		var loc_standing: int = racer_standing_array[i]
		var loc_data: RacerData = racer_data_array[loc_standing]
		#add item
		race_results_item[i] = race_results_item_scene.instance()
		#todo: init item data
		#init_item(placement: int, given_color: Color, given_name: String, given_team: String, given_time: float) -> void:
		race_results_item[i].init_item(i+1, loc_data.car_color, loc_data.driver_name, loc_data.team_name, GameManager.last_recorded_time)
		
		race_results_grid_ref.add_child(race_results_item[i])
		#add seperator
		race_results_grid_ref.add_child(HSeparator.new())
