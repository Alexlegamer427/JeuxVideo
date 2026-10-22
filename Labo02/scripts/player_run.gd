class_name PlayerRun
extends BaseState

@export var player : Player

func enter() -> void:
	player.get_animation_player().play("running")

func handle_inputs(_input_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	var dir := player.move_horizontal()
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "Jump")
	elif not player.is_on_floor():
		Transitioned.emit(self, "Fall")
	elif dir == 0:
		Transitioned.emit(self, "Idle")

func exit() -> void:
	pass
