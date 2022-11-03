extends Camera2D

const zoomCurve = preload("res://Curves/Zoom_Curve.tres")

# Declare member variables here. Examples:
var mouse_start_pos: Vector2
var screen_start_position: Vector2
var movement_type
var last_mouse_pos: Vector2

var scroll_step: float = 0.34
var max_zoom: float = 10
var min_zoom: float = 0.1
var drag_zoom_div: float = 200

var dragging: bool = false

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			match event.button_index:
				1, 3:  #left or middle mouse
					movement_type = Enums.CAM_MOVE_STATE.DRAG
					mouse_start_pos = event.position
					screen_start_position = position
					dragging = true
				2:    #right mouse
					movement_type = Enums.CAM_MOVE_STATE.ZOOM
					mouse_start_pos = event.position
					screen_start_position = position
					dragging = true
					last_mouse_pos = event.position
				4:    #scroll up
					movement_type = Enums.CAM_MOVE_STATE.SCROLL
					zoom.x -= scroll_step * zoomCurve.interpolate(zoom.x / max_zoom)
					zoom.y -= scroll_step * zoomCurve.interpolate(zoom.y / max_zoom)
					limitZoom()
				5:    #scroll down
					movement_type = Enums.CAM_MOVE_STATE.SCROLL
					zoom.x += scroll_step * zoomCurve.interpolate(zoom.x / max_zoom)
					zoom.y += scroll_step * zoomCurve.interpolate(zoom.y / max_zoom)
					limitZoom()
		else:
			dragging = false
	elif event is InputEventMouseMotion and dragging:
		match movement_type:
			Enums.CAM_MOVE_STATE.DRAG:
				position = zoom * (mouse_start_pos - event.position) + screen_start_position
				limitView()
			Enums.CAM_MOVE_STATE.ZOOM:
				var temp = -(last_mouse_pos.y - event.position.y) / drag_zoom_div
				var zoom_distance = temp * zoomCurve.interpolate(temp)
				zoom.x += zoom_distance
				zoom.y += zoom_distance
				smoothing_speed = (log(zoom.x + 1) * 10)
				limitZoom()
				last_mouse_pos = event.position

func limitView():
	if position.x < limit_left:
		position.x = limit_left
		print("limit left")
	elif position.x > limit_right:
		position.x = limit_right
		print("limit right")
	if position.y < limit_top:
		position.y = limit_top
		print("limit top")
	elif position.y > limit_bottom:
		position.y = limit_bottom
		print("limit bottom")

func limitZoom():
	if zoom.x > max_zoom:
		zoom.x = max_zoom
		mouse_start_pos = get_viewport().get_mouse_position()
	elif zoom.x < min_zoom:
		zoom.x = min_zoom
		mouse_start_pos = get_viewport().get_mouse_position()
		
	if zoom.y > max_zoom:
		zoom.y = max_zoom
	elif zoom.y < min_zoom:
		zoom.y = min_zoom
