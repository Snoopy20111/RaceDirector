extends PanelContainer


# Declare member variables here. Examples:
onready var rect_ref = $ColorRect

func set_flag_color(input_state: int):
	#Enums.FLAG_STATE
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
			rect_ref.color = Color.purple
		#Meatball, will require a texture later
		6:
			rect_ref.color = Color.orange
		#Blue
		7:
			rect_ref.color = Color.blue
