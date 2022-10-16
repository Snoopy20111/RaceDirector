extends Control

const myEnums = preload("res://Scripts/myEnums.gd")
const LogoFade_Curve = preload("res://Curves/LogoFade_Curve.tres")

# Declare member variables here. Examples:

var StartTimer
var FreezeTimer
var EndTimer
var LogoAnim

var FadeCounter = 0
export var fade_value = myEnums.FADE_STATE.PAUSE

export var FadeIn_Length = .5
export var FadeOut_Length = .5

# Called when the node enters the scene tree for the first time.
func _ready():
	StartTimer = $StartTimer
	FreezeTimer = $FreezeTimer
	EndTimer = $EndTimer
	LogoAnim = $CenterContainer/LogoAnim
	StartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	match (fade_value):
		myEnums.FADE_STATE.IN:
			# add to alpha value, and run fade counter value through the fade curve
			FadeCounter += delta
			LogoAnim.modulate.a = LogoFade_Curve.interpolate(FadeCounter / FadeIn_Length)
			# once we pass 1, pause the animation and reset the counter
			if (FadeCounter >= 1):
				fade_value = myEnums.FADE_STATE.PAUSE
				FadeCounter = 0
		myEnums.FADE_STATE.OUT:
			# add to alpha value, and go in reverse down through the fade curve values
			FadeCounter += delta
			LogoAnim.modulate.a = LogoFade_Curve.interpolate(1 - (FadeCounter / FadeOut_Length))
			# once we pass 1 again, pause the animation (should be invisible) and wait the length of the timer before dying
			if (FadeCounter >= 1):
				fade_value = myEnums.FADE_STATE.PAUSE
				EndTimer.start()


func _on_LogoAnim_finished():
	# pause anim and start Freeze Timer
	FreezeTimer.start()
	fade_value = myEnums.FADE_STATE.PAUSE


func _on_StartTimer_timeout():
	fade_value = myEnums.FADE_STATE.IN
	LogoAnim.play()

func _on_FreezeTimer_timeout():
	fade_value = myEnums.FADE_STATE.OUT

func _on_EndTimer_timeout():
	SceneManager.change_scene("res://Scenes/Tracks/StartYourEngines.tscn")
	pass
