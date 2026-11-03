class_name MainMenu
extends Control

@onready var start_button : Button = %StartButton
@onready var options_button : Button = %OptionsButton
@onready var quit_button : Button = %QuitButton

func _ready() -> void:
	start_button.pressed.connect(_on_start_pressed)
	options_button.pressed.connect(_on_options_pressed)
	quit_button.pressed.connect(_on_quit_pressed)
	start_button.grab_focus()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_options_pressed() -> void:
	pass # Voir la section sur les options

func _on_quit_pressed() -> void:
	get_tree().quit()
	
	
	
func _input(event):
	if event.is_action_pressed("down"):
		get_viewport().gui_get_focus_owner().find_next_valid_focus().grab_focus()
	elif event.is_action_pressed("up"):
		get_viewport().gui_get_focus_owner().find_prev_valid_focus().grab_focus()
