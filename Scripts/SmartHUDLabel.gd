extends RichTextLabel


# Declare member variables here. Examples:
export var title = ""
export var defaultValue = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	generalUpdate(defaultValue)

func _on_Update(value):
	var tempVal = value
	if (typeof(value) == TYPE_REAL):
		tempVal = int(tempVal)
	generalUpdate(tempVal)
	
func generalUpdate(value):
	self.set_text(title + str(value))
