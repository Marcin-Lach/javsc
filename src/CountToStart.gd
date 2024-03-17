extends Label

@onready var count_to_start_timer = $"../../CountToStartTimer"

func _ready():
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2, 2), 0.5)
	tween.tween_property(self, "scale", Vector2(0, 0), 0.5)
	tween.tween_property(self, "scale", Vector2(2, 2), 0.5)
	tween.tween_property(self, "scale", Vector2(0, 0), 0.5)
	tween.tween_property(self, "scale", Vector2(2, 2), 0.5)
	tween.tween_property(self, "scale", Vector2(0, 0), 0.5)

func _process(delta):
	text = str(int(count_to_start_timer.time_left) + 1)
