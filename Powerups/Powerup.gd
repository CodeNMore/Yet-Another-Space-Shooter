extends Area2D
class_name Powerup

export var speed := 50.0

func _physics_process(delta):
	position.y += speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func onCollect(player: Player):
	pass

func _on_Powerup_area_entered(area):
	if area is Player:
		onCollect(area)
		queue_free()
