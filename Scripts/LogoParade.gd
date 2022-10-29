extends Control

const LogoFade_Curve = preload("res://Curves/LogoFade_Curve.tres")

# Declare member variables here. Examples:

var StartTimer: Timer
var FreezeTimer: Timer
var LogoAnim: AnimatedSprite
var NameLabel: Label

var FadeCounter = 0
export var fade_value = MyEnums.FADE_STATE.PAUSE

export var FadeIn_Length = .5
export var FadeOut_Length = .5

var transitioning : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	StartTimer = $StartTimer as Timer
	FreezeTimer = $FreezeTimer as Timer
	LogoAnim = $CenterContainer/LogoAnim as AnimatedSprite
	NameLabel = $Name as Label
	StartTimer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	match (fade_value):
		MyEnums.FADE_STATE.IN:
			# add to alpha value, and run fade counter value through the fade curve
			FadeCounter += delta
			LogoAnim.modulate.a = LogoFade_Curve.interpolate(FadeCounter / FadeIn_Length)
			# once we pass 1, pause the animation and reset the counter
			if (FadeCounter >= 1):
				fade_value = MyEnums.FADE_STATE.PAUSE
				FadeCounter = 0
		MyEnums.FADE_STATE.OUT:
			# add to alpha value, and go in reverse down through the fade curve values
			FadeCounter += delta
			LogoAnim.modulate.a = LogoFade_Curve.interpolate(1 - (FadeCounter / FadeOut_Length))
			# once we pass 1 again, pause the animation (should be invisible) and wait the length of the timer before dying
			if (FadeCounter >= 1):
				fade_value = MyEnums.FADE_STATE.PAUSE
			if (!transitioning && FadeCounter >= .18):
				SceneManager.change_scene("res://Scenes/UI_Scenes/MainMenu.tscn")
				transitioning = true


func _on_LogoAnim_finished():
	# pause anim and start Freeze Timer
	FreezeTimer.start()
	fade_value = MyEnums.FADE_STATE.PAUSE


func _on_StartTimer_timeout():
	fade_value = MyEnums.FADE_STATE.IN
	LogoAnim.play()

func _on_FreezeTimer_timeout():
	fade_value = MyEnums.FADE_STATE.OUT
