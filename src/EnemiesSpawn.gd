extends Node2D

@export var enemies_count = 50
var renemy_scene = preload("res://Enemies/Renemy/renemy.tscn")
var yenemy_scene = preload("res://Enemies/Yenemy/yenemy.tscn")
@onready var pause_label = $Camera2D/PauseLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	pause_label.hide()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause_menu"):
		pause_label.visible = !pause_label.visible
		get_tree().paused = !get_tree().paused


func _on_timer_timeout():
	var player_position = $Player.global_position
	var safe_zone_radius = 65
	
	for i in enemies_count:
		var quadrant = randi_range(0 ,3)
		
		var enemy_position_x = randi_range(-136, 136)
		var enemy_position_y = randi_range(-73, 73)
		match quadrant:
			0:
				enemy_position_x = randi_range(player_position.x - 136, player_position.x - 136 + safe_zone_radius)
				enemy_position_y = randi_range(player_position.y - 73, player_position.y - 73 + safe_zone_radius)
			1:
				enemy_position_x = randi_range(player_position.x + 136, player_position.x + 136 - safe_zone_radius)
				enemy_position_y = randi_range(player_position.y - 73, player_position.y - 73 + safe_zone_radius)
			2:
				enemy_position_x = randi_range(player_position.x + 136, player_position.x + 136 - safe_zone_radius)
				enemy_position_y = randi_range(player_position.y + 73, player_position.y + 73 - safe_zone_radius)
			3:
				enemy_position_x = randi_range(player_position.x - 136, player_position.x - 136 + safe_zone_radius)
				enemy_position_y = randi_range(player_position.y + 73, player_position.y + 73 - safe_zone_radius)
		
		var enemy_type = randi_range(0, 1)

		var enemy
		if enemy_type == 1:
			enemy = renemy_scene.instantiate()
		else:
			enemy = yenemy_scene.instantiate()

		enemy.position.x = enemy_position_x
		enemy.position.y = enemy_position_y
		add_child(enemy)
