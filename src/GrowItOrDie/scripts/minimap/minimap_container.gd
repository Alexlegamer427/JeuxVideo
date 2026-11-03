extends Node

@onready var sub_viewport: SubViewport = %SubViewport

@onready var mini_cam: Camera2D = %MiniCam
@onready var minimapTile : TileMapLayer = %MinimapTile
@export var map : TileMapLayer 
@export var player: CharacterBody2D
@onready var spritePlayer : Sprite2D = %MiniPlayerSprite


const VELOCITY_CHECK : int  = 5   

func _ready() -> void:
	generate_minimap_tile()

func generate_minimap_tile():
	for cell in map.get_used_cells():
		var id = map.get_cell_source_id(cell)
		var atlas = map.get_cell_atlas_coords(cell)
		minimapTile.set_cell(cell, id, atlas)
	
func _process(delta: float) -> void:
	var local_pos: Vector2 = map.to_local(player.global_position)
	mini_cam.position = minimapTile.to_global(local_pos)
	spritePlayer.position = mini_cam.position
