extends Control

var levelCompleted = false
var animation = 0
@export var nextLevel = preload("res://Scenes/Levels/LevelProtype.tscn")
@onready var noTouched : AnimationPlayer = $Label/NoTouchedCableWhale/NoTouchedWhale
@onready var lowTiles : AnimationPlayer = $Label/LowTilesWhale/LowWhale
@export var tilesInLevel = 2

func _process(delta : float) -> void:
	if Input.is_action_pressed("RESET"):
		set_physics_process(false)
		get_tree().call_deferred("reload_current_scene")
	elif levelCompleted and Input.is_action_pressed("NEXT"):
		print(nextLevel)
	
		get_tree().change_scene_to_packed(nextLevel)
		
		
func _on_circuit_counter_level_completed(tiles, touchedCable) -> void:
	print(tiles)
	if tiles <= tilesInLevel:
		lowTiles.play("fullWhale")
	if not touchedCable:
		noTouched.play("fullWhale")
	get_tree().paused = true
	levelCompleted = true
	visible = true  

func _on_timer_timeout() -> void:
	animation += 1
	
	match (animation):
		1:
			$Label.visible = true
		2:
			$Label/LevelCompleteWhale.visible = true
		3:
			$Label/NoTouchedCableWhale.visible = true
		4:
			$Label/LowTilesWhale.visible = true
		5:
			$Timer.stop()
