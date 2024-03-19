extends RigidBody2D

@onready var player_node = $"/root/Main/Player"
@export var speed = 10
@onready var spawn_timer = $SpawnTimer
@onready var spawn_sprite = $SpawnSprite
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $AnimatedSprite2D

var spawn_tick_count = 10

func _ready():
	sprite_2d.hide()
	collision_shape_2d.disabled = true
	self.freeze = true
	spawn_timer.start()
	spawn_sprite.show()

func _physics_process(delta):
	var direction_vector = position.direction_to(player_node.position)
	linear_velocity = direction_vector * speed

func _on_spawn_timer_timeout():
	if spawn_tick_count > 0:
		spawn_tick_count -= 1
		spawn_sprite.visible = !spawn_sprite.visible
	else:
		spawn_timer.stop()
		spawn_sprite.hide()
		sprite_2d.show()
		collision_shape_2d.disabled = false
		self.freeze = false
