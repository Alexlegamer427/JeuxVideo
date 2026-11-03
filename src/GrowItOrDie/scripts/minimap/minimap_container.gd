extends Node

@onready var sub_viewport: SubViewport = %SubViewport

@onready var mini_cam: Camera2D = %MiniCam
@onready var minimapTile : Node2D = %MinimapTile
@export var map : TileMapLayer 
@export var player: CharacterBody2D

const SCALE : int  = 8   

func _ready() -> void:
	sub_viewport.world_2d = get_tree().root.world_2d
	sub_viewport.get_tree().root.set_canvas_cull_mask_bit(1, false)
	generate_minimap_tile()

func generate_minimap_tile():
	for cell in map.get_used_cells():
		var id = map.get_cell_source_id(cell)
		var atlas = map.get_cell_atlas_coords(cell)
		minimapTile.set_cell(cell, id, atlas)
	

func _process(delta: float) -> void:
	mini_cam.position = player.global_position 
