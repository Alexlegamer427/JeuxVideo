class_name PlayerIdle
extends BaseState

@export var player : Player

func enter() -> void:
	player.get_animation_player().play("idle")

func handle_inputs(_input_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	elif Input.is_action_just_pressed("jump") and player.is_on_floor():
		Transitioned.emit(self, "Jump")
	elif not player.is_on_floor():
		Transitioned.emit(self, "Fall")
	elif Input.get_axis("left", "right") != 0:
		Transitioned.emit(self, "Run")

func exit() -> void:
	pass
