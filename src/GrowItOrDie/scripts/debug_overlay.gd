extends CanvasLayer

const MO := 1048576.0        
const COLLISION_COLOR := Color(0.0, 0.7, 1.0, 0.35)
const VELOCITY_COLOR := Color.YELLOW
const VELOCITY_SCALE := 0.3                

var label := Label.new()
var canvas := Node2D.new()               
var player: CharacterBody2D

func _ready() -> void:
	layer = 1000
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	canvas.draw.connect(_draw_debug)
	add_child(canvas)
	add_child(label)                    


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_toggle"):
		visible = not visible

func register_player(player_ref: CharacterBody2D) -> void:
	player = player_ref

func _process(_delta: float) -> void:
	if visible:
		label.text = _build_text()
		canvas.queue_redraw()

func _stat(monitor: Performance.Monitor) -> int:
	return int(Performance.get_monitor(monitor))


func _player() -> CharacterBody2D:
	return get_tree().get_first_node_in_group("player") as CharacterBody2D


func _build_text() -> String:
	var lines := PackedStringArray([
		"FPS : %d" % Engine.get_frames_per_second(),
		"Frame : %.2f ms" % (Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0),
		"RAM : %.1f Mo" % (OS.get_static_memory_usage() / MO),
		"Objets : %d  Noeuds : %d" % [_stat(Performance.OBJECT_COUNT), _stat(Performance.OBJECT_NODE_COUNT)],
		"Vitesse : %s" % player.velocity 
	])	
	return "\n".join(lines)


func _draw_debug() -> void:
	var to_screen := get_viewport().get_canvas_transform()

	for node in get_tree().root.find_children("*", "CollisionShape2D", true, false):
		var cs := node as CollisionShape2D
		if cs.shape and not cs.disabled:
			canvas.draw_set_transform_matrix(to_screen * cs.global_transform)
			cs.shape.draw(canvas.get_canvas_item(), COLLISION_COLOR)
	canvas.draw_set_transform_matrix(Transform2D.IDENTITY)


	var player := _player()
	if player:
		var start := to_screen * player.global_position
		canvas.draw_line(start, start + player.velocity * VELOCITY_SCALE, VELOCITY_COLOR, 2.0)
