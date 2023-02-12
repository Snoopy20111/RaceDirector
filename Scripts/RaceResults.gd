extends ScrollContainer


# Declare member variables here. Examples:
var race_results_item: Array
var race_results_item_scene = preload("res://Scenes/Prefabs/RaceResults_Item.tscn")


onready var race_results_grid_ref = $PanelContainer/RaceResults_Grid



# Called when the node enters the scene tree for the first time.
func _ready():
	var racer_data_array = GameManager.racerDataArray
	var racer_standing_array: PoolIntArray = GameManager.racerStandingArray
	var racer_array_size: int = racer_standing_array.size()
	
	#add the necessary items in order of their finishing placement
	race_results_item.resize(racer_array_size)
	for i in racer_array_size:
		var loc_standing: int = racer_standing_array[i]
		var loc_data: RacerData = racer_data_array[loc_standing]
		#add item
		race_results_item[i] = race_results_item_scene.instance()
		race_results_grid_ref.add_child(race_results_item[i])
		#init item data, done after add_child so all the references to child nodes exist in race_result_item
		#init_item(placement: int, given_color: Color, given_name: String, given_team: String, given_time: float) -> void:
		race_results_item[i].init_item(i+1, loc_data.car_color, loc_data.driver_name, loc_data.team_name, GameManager.last_recorded_time)
		#add seperator
		race_results_grid_ref.add_child(HSeparator.new())
