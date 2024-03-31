extends RigidBody2D
class_name Player

@export var _speed = 100
var _dash_speed_multiplier = 3.0 as float
var _current_speed_multiplier = 1.0 as float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _physics_process(delta):
	_set_velocity()	


func _on_body_entered(body):
	if body.is_in_group("enemies"):
		get_tree().reload_current_scene()


func _set_velocity():
	var input_direction = Input.get_vector("left", "right", "up", "down") as Vector2
	_handle_dash(input_direction)
	linear_velocity = input_direction * _speed * _current_speed_multiplier


func _handle_dash(current_input_direction : Vector2):
	if current_input_direction.is_zero_approx() == false:
		if Input.is_action_just_pressed("dash"):
			if _current_speed_multiplier == 1.0:
				_current_speed_multiplier = _dash_speed_multiplier
				
				var speed_multiplier_tween = (create_tween()
						.set_pause_mode(Tween.TWEEN_PAUSE_STOP)
						.set_ease(Tween.EASE_IN_OUT)
						.set_trans(Tween.TRANS_BACK)) # this will make player exceed the _dash_speed_multiplier briefly, but then _current_speed_multiplier will fall below 1.0 for a short period
				speed_multiplier_tween.tween_property(self, "_current_speed_multiplier", 1.0, 0.5)
