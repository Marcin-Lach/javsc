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
		hud.toggle_pause()

func _on_hud_countdown_completed():
	time_left_timer.start()	
	hud.show_message("SURVIVE!", 2, Vector2(2.0, 2.0))
	spawn_enemies()
	
func spawn_enemies():
	var player_position = $Player.global_position
	var half_viewport_size = get_viewport_rect().size/2
	var safe_zone = 55
	
	var player_safe_zone = Rect2(player_position - Vector2(safe_zone/2, safe_zone/2), Vector2(safe_zone, safe_zone))
	print(str("player safe zone: ", player_safe_zone, player_safe_zone.end))
	
	var spawn_boundaries = Rect2(Vector2(player_position.x - half_viewport_size.x, player_position.y - half_viewport_size.y), get_viewport_rect().size)
	print(str("spawn boundaries: ", spawn_boundaries))
	
	for i in enemies_count:
		var enemy_position = calculate_enemy_position(spawn_boundaries)
		while(player_safe_zone.has_point(enemy_position)):
			print("recalculating enemy_position")
			enemy_position = calculate_enemy_position(spawn_boundaries)

		var enemy_type = randi_range(0, 1)

		var enemy
		if enemy_type == 1:
			enemy = renemy_scene.instantiate()
		else:
			enemy = yenemy_scene.instantiate()

		enemy.set_target($Player)
		enemy.position.x = enemy_position.x
		enemy.position.y = enemy_position.y
		add_child(enemy)

func calculate_enemy_position(spawn_boundaries: Rect2) -> Vector2:
	var enemy_position_x = randi_range(spawn_boundaries.position.x, spawn_boundaries.end.x)
	var enemy_position_y = randi_range(spawn_boundaries.position.y, spawn_boundaries.end.y)
	var enemy_position = Vector2(enemy_position_x, enemy_position_y)
	print(str("enemy_position ", enemy_position))
	return enemy_position
	
	
func _on_time_left_timer_timeout():
	await hud.show_message("WINNER!", 0, Vector2(2.0, 2.0))
	get_tree().call_group("enemies", "queue_free")
