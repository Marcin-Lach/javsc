extends Label

@onready var time_left_timer = $"../../TimeLeftTimer"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var minutes = time_left_timer.time_left / 60
	var seconds = fmod(time_left_timer.time_left, 60)
	var formatted_time_left = "%02d:%02d" % [minutes, seconds]
	text = formatted_time_left
