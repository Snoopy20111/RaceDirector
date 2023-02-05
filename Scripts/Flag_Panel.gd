extends PanelContainer


# Declare member variables here. Examples:
onready var rect_ref = $ColorRect

func _ready():
# warning-ignore:return_value_discarded
	GameManager.connect("flag_changed", self, "set_flag_color")

func set_flag_color(input_state: int):
	#Enums.FLAG_STATE {GREEN, YELLOW, RED, WHITE, BLACK, CHECKER, MEATBALL, BLUE}
	match(input_state):
		#Green
		0:
			rect_ref.color = Color.green
		#Yellow
		1:
			rect_ref.color = Color.yellow
		#Red
		2:
			rect_ref.color = Color.red
		#White
		3:
			rect_ref.color = Color.white
		#Black
		4:
			rect_ref.color = Color.black
		#Checker, which will definitely require a texture later
		5:
			rect_ref.color = Color.gray
		#Meatball, will require a texture later
		6:
			rect_ref.color = Color.orange
		#Blue
		7:
			rect_ref.color = Color.blue
