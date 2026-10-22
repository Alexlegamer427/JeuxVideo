class_name PlayerFall
extends BaseState

@export var player : Player

func enter() -> void:
	player.get_animation_player().play("falling")

func handle_inputs(_input_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.move_horizontal()
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	elif player.is_on_floor():
		Transitioned.emit(self, "Idle")

func exit() -> void:
	pass
