class_name PauseMenu
extends CanvasLayer

@onready var resume_button : Button = %ResumeButton
@onready var options_button : Button = %OptionsButton
@onready var main_menu_button : Button = %MainMenuButton

func _ready() -> void:
	hide()
	resume_button.pressed.connect(resume)
	main_menu_button.pressed.connect(_on_main_menu_pressed)

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if visible:
			resume()
		else:
			pause()
		get_viewport().set_input_as_handled()
		
	var focus = get_viewport().gui_get_focus_owner()
	if focus == null:
		return
		
	if event.is_action_pressed("down"):
		var voisin = focus.find_valid_focus_neighbor(SIDE_BOTTOM)
		if voisin: voisin.grab_focus()
	elif event.is_action_pressed("up"):
		var voisin = focus.find_valid_focus_neighbor(SIDE_TOP)
		if voisin: voisin.grab_focus()

func pause() -> void:
	get_tree().paused = true
	show()
	resume_button.grab_focus()

func resume() -> void:
	get_tree().paused = false
	hide()

func _on_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menus/main_menu.tscn")
