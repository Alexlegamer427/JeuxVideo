class_name PlayerIdle
extends BaseState

@export var player : Player

func enter() -> void:
	player.velocity = Vector2.ZERO
	player.play_anim("idle")

func handle_inputs(_input_event: InputEvent) -> void: pass
func update(_delta: float) -> void: pass
func exit() -> void: pass

func physics_update(_delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		Transitioned.emit(self, "Attack")
	elif Input.get_vector("left", "right", "up", "down") != Vector2.ZERO:
		Transitioned.emit(self, "Run")
