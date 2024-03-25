extends Node2D

@export var enemies_count = 50
var renemy_scene = preload("res://Enemies/Renemy/renemy.tscn")
var yenemy_scene = preload("res://Enemies/Yenemy/yenemy.tscn")
@onready var time_left_timer = $TimeLeftTimer as Timer
@onready var hud = $Hud as Hud

var countdown_before_start_seconds : int = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	$Camera2D.set_target($Player)
	await hud.countdown_to_start(countdown_before_start_seconds)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var time_left = time_left_timer.time_left
	hud.set_time_left(time_left)

	if Input.is_action_just_pressed("pause_menu"):
		get_tree().paused = !get_tree().paused
		if get_tree().paused:
			await hud.show_message("Game paused")
		else:
			hud.hide_message()

func _on_hud_countdown_completed():
	time_left_timer.start()	
	hud.show_message("SURVIVE!", 2, Vector2(2.0, 2.0))
	
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

		enemy.set_target($Player)
		enemy.position.x = enemy_position_x
		enemy.position.y = enemy_position_y
		add_child(enemy)


func _on_time_left_timer_timeout():
	await hud.show_message("WINNER!", 0, Vector2(2.0, 2.0))
	get_tree().call_group("enemies", "queue_free")
