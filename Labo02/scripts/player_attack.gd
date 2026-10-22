class_name PlayerAttack
extends BaseState

@export var player : Player

func enter() -> void:
	var anim := player.get_animation_player()
	anim.play("attack")
	anim.animation_finished.connect(_on_attack_finished, CONNECT_ONE_SHOT)

func handle_inputs(_input_event: InputEvent) -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	player.move_horizontal()

func exit() -> void:
	pass

func _on_attack_finished(_anim_name: StringName) -> void:
	if not player.is_on_floor():
		Transitioned.emit(self, "Fall")
	elif Input.get_axis("left", "right") != 0:
		Transitioned.emit(self, "Run")
	else:
		Transitioned.emit(self, "Idle")
