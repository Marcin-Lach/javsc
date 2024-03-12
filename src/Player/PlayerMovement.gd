extends RigidBody2D

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func set_velocity():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	linear_velocity = input_direction * speed
	
func _physics_process(delta):
	set_velocity()	

func _on_body_entered(body):
	if body.is_in_group("enemies"):
		get_tree().reload_current_scene()
