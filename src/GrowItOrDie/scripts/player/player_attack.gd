class_name PlayerAttack
extends BaseState

@export var player : Player

func enter() -> void:
	player.velocity = Vector2.ZERO   # le joueur s'arrête pendant le coup
	player.play_anim("attack")
	player.get_animation_player().animation_finished.connect(_on_finished, CONNECT_ONE_SHOT)

func handle_inputs(_input_event: InputEvent) -> void: pass
func update(_delta: float) -> void: pass
func physics_update(_delta: float) -> void: pass
func exit() -> void: pass

func _on_finished(_anim_name: StringName) -> void:
	if Input.get_vector("left", "right", "up", "down") != Vector2.ZERO:
		Transitioned.emit(self, "Run")
	else:
		Transitioned.emit(self, "Idle")
