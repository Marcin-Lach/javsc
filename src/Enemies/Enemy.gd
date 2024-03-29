extends RigidBody2D

@export var speed = 10
@onready var spawn_timer = $SpawnTimer
@onready var spawn_sprite = $SpawnSprite
@onready var collision_shape_2d = $CollisionShape2D
@onready var sprite_2d = $AnimatedSprite2D

var target : Node2D
var spawn_tick_count = 10

func set_target(theTarget : Node2D):
	target = theTarget
	
func _ready():
	sprite_2d.hide()
	collision_shape_2d.disabled = true
	self.freeze = true
	spawn_timer.start()
	spawn_sprite.show()

func _process(delta):
	var living_range = Rect2(target.global_position - get_viewport_rect().size/4*3, get_viewport_rect().size * 1.5)
	if(living_range.has_point(self.global_position) == false):
		queue_free()

func _physics_process(delta):
	if target == null:
		return

	var direction_vector = position.direction_to(target.position)
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
