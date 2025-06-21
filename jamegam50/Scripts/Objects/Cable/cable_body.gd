extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var anim: AnimationPlayer = $AnimationPlayer
var spriteSelected :String = "horizontal"

func set_sprite(name: String) -> void:
	spriteSelected = name   
	if is_inside_tree():    # por si se llama más tarde
		anim.play(name)
		anim.stop()


func _ready() -> void:
	anim.play(name)    
	anim.stop()  
