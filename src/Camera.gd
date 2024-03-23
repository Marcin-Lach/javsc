extends Camera2D

@onready var player_node = $"/root/Main/Player"

var target : Node2D

func set_target(theTarget : Node2D):
	target = theTarget

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target != null:
		position = target.position
