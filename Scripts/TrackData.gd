extends Path2D

const myEnums = preload("res://Scripts/myEnums.gd")


var carRef
var pitLaneRef
var pitEntranceRef
var pitExitRef

var carCount = 1
var isPitOpen = true
var isPitExitOpen = true
var rejoinPoint

# Called when the node enters the scene tree for the first time.
func _ready():
	carRef = $Car
	pitLaneRef = $PitLane
	pitEntranceRef = $PitLane/PitEntrance
	pitExitRef = $PitLane/PitExit
	for i in carCount:
		pass
	
	# unholy calculation to get the offset of the last point on the Pit Lane
	rejoinPoint = self.curve.get_closest_offset(pitLaneRef.curve.get_point_position(pitLaneRef.curve.get_point_count() - 1))


func _on_PitEntrance_area_entered(area):
	if (carRef == area.get_parent()):
		if ((carRef.willPitNextLap) and (carRef.currentCarState == myEnums.CAR_STATE.ON_TRACK) and (isPitOpen)):
			carRef.currentCarState = myEnums.CAR_STATE.PITTING
			carRef.willPitNextLap = false
			carRef.emit_signal("PittingIntent", false)
			carRef.offset = 0
			
			reparent(carRef, $PitLane)


func _on_PitExit_area_entered(area):
	if (carRef == area.get_parent()):
		if ((carRef.currentCarState == myEnums.CAR_STATE.PITTING) and isPitExitOpen):
			carRef.currentCarState = myEnums.CAR_STATE.ON_TRACK
			reparent(carRef, self)
			carRef.offset = rejoinPoint



########### Utility Functions ###########

func reparent(child: Node, new_parent: Node):
	var old_parent = child.get_parent()
	old_parent.remove_child(child)
	new_parent.add_child(child)
