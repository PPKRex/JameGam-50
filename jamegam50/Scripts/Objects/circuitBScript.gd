extends Node2D
@onready var area = $Area2D

signal death()

func _on_area_2d_mouse_entered() -> void:
	emit_signal("death")
	print("MUELTO")	
