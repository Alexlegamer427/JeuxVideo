class_name Player
extends CharacterBody2D

const SPEED := 90.0

var facing := Vector2.DOWN   

func _ready() -> void:
	DebugOverlay.register_player(self)

func get_animation_player() -> AnimationPlayer:
	return $AnimationPlayer

func _physics_process(_delta: float) -> void:
	move_and_slide()


func move_input() -> Vector2:
	var dir := Input.get_vector("left", "right", "up", "down")
	velocity = dir * SPEED
	if dir != Vector2.ZERO:
		facing = dir
	return dir


func facing_name() -> String:
	if abs(facing.x) > abs(facing.y):
		return "right" if facing.x > 0 else "left"
	return "down" if facing.y > 0 else "up"


func play_anim(prefix: String) -> void:
	get_animation_player().play(prefix + "_" + facing_name())
