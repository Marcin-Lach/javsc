extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta):
	if Input.is_key_pressed(KEY_RIGHT):
		linear_velocity.x += 10
		
	if Input.is_key_pressed(KEY_LEFT):
		linear_velocity.x -= 10
	
	if Input.is_key_pressed(KEY_UP):
		linear_velocity.y -= 10
		
	if Input.is_key_pressed(KEY_DOWN):
		linear_velocity.y += 10
		

