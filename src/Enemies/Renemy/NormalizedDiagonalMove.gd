extends RigidBody2D

func _physics_process(delta):
	var movement_vec = Vector2(1, -1)
	movement_vec = movement_vec.normalized() # normalized, to match movements in single direction
	position += movement_vec
