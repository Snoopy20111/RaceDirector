extends MarginContainer


# Declare member variables here. Examples:
var race_results_item: Array
var race_results_item_scene = preload("res://Scenes/Prefabs/RaceResults_Item.tscn")


onready var race_results_grid_ref = $ScrollContainer/PanelContainer/RaceResults_Grid



# Called when the node enters the scene tree for the first time.
func _ready():
	#add the necessary items in order of their finishing placement
	for i in GameManager.racerStandingsArray.size():
		#add item
		#add seperator
		#init item data
		pass
	pass
