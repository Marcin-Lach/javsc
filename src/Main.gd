extends Node2D

const COUNTDOWN_BEFORE_START_SECONDS = 3 as int
@export var enemies_count = 50 as int
var _renemy_scene = preload("res://Enemies/Renemy/renemy.tscn") as PackedScene
var _yenemy_scene = preload("res://Enemies/Yenemy/yenemy.tscn") as PackedScene
var _top_up_enemies = false as bool
@onready var _time_left_timer = $TimeLeftTimer as Timer
@onready var _hud = $Hud as Hud


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D.set_target($Player)
	await _hud.countdown_to_start(COUNTDOWN_BEFORE_START_SECONDS)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	var time_left = _time_left_timer.time_left
	_hud.set_time_left(time_left)
	
	if _top_up_enemies:
		if get_tree().get_nodes_in_group("enemies").size() < enemies_count:
			_spawn_enemies(1)

	if Input.is_action_just_pressed("pause_menu"):
		_pause_game()
		_hud.toggle_pause()


func _on_hud_countdown_completed() -> void:
	_time_left_timer.start()	
	_hud.show_message("SURVIVE!", 2, Vector2(1.0, 1.0))
	_spawn_enemies(enemies_count)
	_top_up_enemies = true


func _spawn_enemies(enemies_to_spawn : int) -> void:
	var player_position = $Player.global_position
	var half_viewport_size = get_viewport_rect().size/2
	var safe_zone = 55
	
	var player_safe_zone = Rect2(player_position - Vector2(safe_zone/2, safe_zone/2), Vector2(safe_zone, safe_zone))	
	var spawn_boundaries = Rect2(Vector2(player_position.x - half_viewport_size.x, player_position.y - half_viewport_size.y), get_viewport_rect().size)
	
	for i in enemies_to_spawn:
		var enemy_position = _calculate_enemy_position(spawn_boundaries)
		while(player_safe_zone.has_point(enemy_position)):
			enemy_position = _calculate_enemy_position(spawn_boundaries)

		var enemy_type = randi_range(0, 1)

		var enemy
		if enemy_type == 1:
			enemy = _renemy_scene.instantiate()
		else:
			enemy = _yenemy_scene.instantiate()

		enemy.set_target($Player)
		enemy.position.x = enemy_position.x
		enemy.position.y = enemy_position.y
		add_child(enemy)


func _calculate_enemy_position(spawn_boundaries: Rect2) -> Vector2:
	var enemy_position_x = randi_range(spawn_boundaries.position.x, spawn_boundaries.end.x)
	var enemy_position_y = randi_range(spawn_boundaries.position.y, spawn_boundaries.end.y)
	var enemy_position = Vector2(enemy_position_x, enemy_position_y)
	return enemy_position


func _pause_game() -> void:
	get_tree().paused = !get_tree().paused


func _on_time_left_timer_timeout() -> void:
	_top_up_enemies = false
	await _hud.show_message("WINNER!", 0, Vector2(2.0, 2.0))
	get_tree().call_group("enemies", "queue_free")


func _on_hud_pause_menu_hidden() -> void:
	_pause_game()


func _on_hud_restart_game_requested() -> void:
	_pause_game()
	get_tree().change_scene_to_file("res://main.tscn")


