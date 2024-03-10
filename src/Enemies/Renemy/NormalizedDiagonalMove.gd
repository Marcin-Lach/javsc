extends RigidBody2D

@export var speed = 10

func _physics_process(delta):
	var movement_vector = Vector2(1, -1)
	movement_vector = movement_vector.normalized() # normalized, to match movements in single direction
	linear_velocity += movement_vector * speed
