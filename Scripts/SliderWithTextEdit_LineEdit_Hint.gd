extends Label


# Declare member variables here. Examples:
export var invertVisibility: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if (invertVisibility):
		visible = true
	else:
		visible = false


func _on_LineEdit_text_changed(_new_text):
	if (invertVisibility):
		visible = false
	else:
		visible = true


func _on_LineEdit_text_entered(_new_text):
	if (invertVisibility):
		visible = true
	else:
		visible = false
