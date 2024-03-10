extends RigidBody2D

@export var speed = 10

func _physics_process(delta):
	var movement_vector = Vector2(1, -1) # not normalized, will result in movement over a longer distance
	linear_velocity += movement_vector * speed
