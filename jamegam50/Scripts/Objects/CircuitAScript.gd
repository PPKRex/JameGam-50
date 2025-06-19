extends Node2D
signal iniciar_cable(posicion_inicio)

@onready var area = $Area2D

func _on_area_2d_mouse_entered() -> void:
	print("¡Interruptor activado!")	

func _on_area_2d_mouse_exited() -> void:
	print("El cursor ha salido del interruptor.")


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("CLICKQUITI")
		emit_signal("iniciar_cable", global_position)
