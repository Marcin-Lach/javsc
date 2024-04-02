extends Control


func _ready():
	$VBoxContainer/BackButton.grab_focus()


func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://menu.tscn")
