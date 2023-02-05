extends HBoxContainer


onready var placement_ref = $RaceResults_Placement
onready var color_rect_ref = $ColorRect
onready var up_or_down_ref = $UpOrDown
onready var name_ref = $Name
onready var team_ref = $Team
onready var time_ref = $Time

# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass

func init_item(placement: int, given_color: Color, given_name: String, given_team: String, given_time: float) -> void:
	set_placement(placement)
	set_color_rect(given_color)
	set_driver_name(given_name)
	set_team_name(given_team)
	if (placement == 1):
		set_time(given_time, true)
	else:
		set_time(given_time, false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func set_placement(input_num: int) -> void:
	placement_ref.set_number(input_num)


func set_up_or_down(_up_or_down: bool) -> void:
	pass


func set_color_rect(new_color: Color) -> void:
	color_rect_ref.color = new_color


func set_driver_name(new_name: String) -> void:
	name_ref.text = new_name


func set_team_name(new_name: String) -> void:
	team_ref.text = new_name


func set_time(_new_time: float, _is_first: bool) -> void:
	pass
