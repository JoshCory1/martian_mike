extends Sprite2D
 
signal joystick_moved
signal joystick_released

var maxLength = 200
var touchInsideJoystick = false




func _input(event):
	if event is InputEventScreenDrag:
		if touchInsideJoystick == true:
			position.x = position.x + event.relative.x
			position.y = position.y + event.relative.y
			if position.length() > maxLength:
				var angle = position.angle()
				position.x = cos(angle) * maxLength
				position.y = cos(angle) * maxLength
			emit_signal("joystick_moved", position)
	if event is InputEventScreenTouch:
		if event is InputEventScreenTouch and !event.pressed:
			position.x = 0
			position.y = 0
			emit_signal("joystick_released")
		if event.pressed:
			touchInsideJoystick = (event.position - global_position).length() <= 20
