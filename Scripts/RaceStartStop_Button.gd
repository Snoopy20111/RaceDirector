extends Button


export var start_text: String = "Start Race"
export var end_text: String = "End Race"


# Called when the node enters the scene tree for the first time.
func _ready():
	if (GameManager.is_race_active):
		self.text = end_text
	else:
		self.text = start_text
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _pressed():
	if (GameManager.is_race_active == false):
		GameManager._start_race()
		self.text = end_text
		#print ("_pressed, race started from button")
	else:
		GameManager._end_race()
		self.text = start_text
		#print ("_pressed, race ended from button")
