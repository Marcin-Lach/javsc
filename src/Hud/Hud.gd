extends CanvasLayer

class_name Hud
@onready var countdown_label = $CountdownNodeLabel
@onready var message_label = $MessageNodeLabel
@onready var time_left_label = $TimeLeftNodeLabel

signal countdown_completed

var is_paused = false as bool
var message_label_text_before_pause = "" as String

func _ready():
	message_label.hide()

func set_time_left(time_left : float):
	var minutes = time_left / 60
	var seconds = fmod(time_left, 60)
	var formatted_time_left = "%02d:%02d" % [minutes, seconds]
	time_left_label.text = formatted_time_left
	
	if seconds == 0 && minutes == 0:
		time_left_label.hide() 

func countdown_to_start(countdown_seconds: int):
	countdown_label.show()
	var tween = create_tween().set_loops(countdown_seconds)
	tween.tween_property(countdown_label, "scale", Vector2(2, 2), 0.5)
	tween.tween_property(countdown_label, "scale", Vector2(1, 1), 0.5)
	for second in countdown_seconds:
		print(str(second))
		countdown_label.text = str(countdown_seconds-second)
		await get_tree().create_timer(1.0).timeout
	countdown_label.hide()
	time_left_label.show() 
	countdown_completed.emit()

func show_message(message: String, hide_after_seconds: int = 0, scaling : Vector2 = Vector2(1.0, 1.0)):
	message_label.text = message
	message_label.scale = scaling
	message_label.show()
	
	if hide_after_seconds > 0:
		await get_tree().create_timer(hide_after_seconds).timeout
		message_label.hide()
		
	message_label.scale = Vector2(1.0, 1.0)

func hide_message():
	message_label.hide()
