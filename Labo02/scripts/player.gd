class_name Player
extends CharacterBody2D

const SPEED := 200.0
const JUMP_VELOCITY := -350.0

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func get_animation_player() -> AnimationPlayer:
	return $AnimationPlayer 

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

func move_horizontal() -> float:
	var dir := Input.get_axis("left", "right")
	if dir != 0:
		velocity.x = dir * SPEED
		sprite.flip_h = dir < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	return dir
