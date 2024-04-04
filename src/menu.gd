extends Control

@onready var start_button = $VBoxContainer/StartButton


func _ready() -> void:
	start_button.grab_focus()
	

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_options_button_pressed() -> void:
	get_tree().change_scene_to_file("res://options.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_credits_button_pressed() -> void:
	get_tree().change_scene_to_file("res://credits.tscn")
