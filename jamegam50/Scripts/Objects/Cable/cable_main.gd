class_name CableMain extends Node2D

@onready var tileMap : TileMapLayer = $"../TileMapLogic"
var body_scene:PackedScene = preload("res://Scenes/Objects/Cable/CableBody.tscn")

var move_dir:Vector2 = Vector2.ZERO
var previous_move_dir:Vector2 = Vector2.ZERO
var previus_position : Vector2
var has_started := false

func _process(delta : float) -> void:
	if Input.is_action_pressed("UP"):
		if (previous_move_dir != Vector2.DOWN): move_dir = Vector2.UP
	elif Input.is_action_pressed("RIGHT"):
		if (previous_move_dir != Vector2.LEFT): move_dir = Vector2.RIGHT
	elif Input.is_action_pressed("DOWN"):
		if (previous_move_dir != Vector2.UP): move_dir = Vector2.DOWN
	elif Input.is_action_pressed("LEFT"):
		if (previous_move_dir != Vector2.RIGHT): move_dir = Vector2.LEFT

	if not has_started and move_dir != Vector2.ZERO:
		has_started = true
		visible = true     
		
func _on_timer_timeout() -> void:
	update_cable()

func update_cable(): 
	position = position + move_dir * 64
	if has_started:
		detect_tile_water()
		if previus_position:
			spawn_body(previus_position)
		previus_position = position
	
	previous_move_dir = move_dir

func spawn_body(pos:Vector2):
	var body = body_scene.instantiate()
	body.position = pos
	
	get_parent().add_child(body)
	body.set_sprite(update_sprite())
	
	
func detect_tile_water():
	var cell := tileMap.local_to_map(position / 4)
	
	var data : TileData = tileMap.get_cell_tile_data(cell)
	
	if data:
		var is_tile_water:bool = data.get_custom_data("Water")
		if is_tile_water:
			print("water")


func update_sprite()-> String:
	var dir_pair = [previous_move_dir, move_dir]
	match dir_pair:
		[Vector2.UP,    Vector2.UP],    [Vector2.DOWN, Vector2.DOWN]:
			return "vertical"
		[Vector2.LEFT,  Vector2.LEFT],  [Vector2.RIGHT, Vector2.RIGHT]:
			return "horizontal"
		[Vector2.UP,    Vector2.RIGHT], [Vector2.LEFT,  Vector2.DOWN]:
			return "uR"
		[Vector2.DOWN,  Vector2.RIGHT], [Vector2.LEFT,  Vector2.UP]:
			return "dR"
		[Vector2.DOWN,  Vector2.LEFT],  [Vector2.RIGHT, Vector2.UP]:
			return "dL"
		[Vector2.UP,    Vector2.LEFT],  [Vector2.RIGHT, Vector2.DOWN]:
			return "uL"
		[Vector2.ZERO,  Vector2.RIGHT], [Vector2.ZERO,  Vector2.LEFT]:
			return "horizontal"
		[Vector2.ZERO,  Vector2.UP],    [Vector2.ZERO,  Vector2.DOWN]:
			return "vertical"
		
	return "vertical"


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	print("muelto")
