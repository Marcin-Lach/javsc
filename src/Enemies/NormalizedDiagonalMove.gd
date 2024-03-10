extends RigidBody2D

@onready var player_node = $"/root/Main/Player"
@export var speed = 10

func _physics_process(delta):
	var direction_vector = position.direction_to(player_node.position)
	linear_velocity = direction_vector * speed
