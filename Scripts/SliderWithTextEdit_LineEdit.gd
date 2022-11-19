extends LineEdit


func _on_GridContainer_CountUpdated(newCount):
	self.text = String(newCount)
