extends Control

@onready var start_button = $VBoxContainer/StartButton


func _ready():
	start_button.grab_focus()
	

func _on_start_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://options.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
