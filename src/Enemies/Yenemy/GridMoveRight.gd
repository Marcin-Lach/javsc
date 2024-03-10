extends RigidBody2D

func _physics_process(delta):
	var movement_vector
	movement_vector = Vector2(1, 0) # not normalized		
	position += movement_vector
