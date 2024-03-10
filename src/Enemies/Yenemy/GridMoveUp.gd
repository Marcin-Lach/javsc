extends RigidBody2D

@export var speed = 10

func _physics_process(delta):
	var movement_vector
	movement_vector = Vector2(0, -1) # not normalized
	linear_velocity += movement_vector * speed
