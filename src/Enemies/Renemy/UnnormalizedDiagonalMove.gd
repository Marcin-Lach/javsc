extends RigidBody2D

func _physics_process(delta):
	var movement_vec = Vector2(1, -1) # not normalized, will result in movement over a longer distance
	position += movement_vec
