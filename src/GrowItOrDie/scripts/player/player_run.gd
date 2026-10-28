class_name PlayerRun
extends BaseState

@export var player : Player

func enter() -> void:
	pass

func handle_inputs(_input_event: InputEvent) -> void: pass
func update(_delta: float) -> void: pass
func exit() -> void: pass

func physics_update(_delta: float) -> void:
	var dir := player.move_input()
	player.play_anim("run")
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	elif dir == Vector2.ZERO:
		Transitioned.emit(self, "Idle")
