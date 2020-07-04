extends Area2D

export var speed: float = 500

func _physics_process(delta):
	position.y -= speed * delta
