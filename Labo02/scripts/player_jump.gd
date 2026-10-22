class_name PlayerJump
extends BaseState

@export var player : Player

func enter() -> void:
	player.velocity.y = player.JUMP_VELOCITY
	player.get_animation_player().play("jump")

func handle_inputs(_input_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.move_horizontal()
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	elif player.velocity.y >= 0:
		Transitioned.emit(self, "Fall")

func exit() -> void:
	pass
