class_name Powerup
extends Area2D

export var powerupMoveSpeed: float = 50

func _physics_process(delta: float) -> void:
	position.y += powerupMoveSpeed * delta

func applyPowerup(player: Player):
	# This needs to be implemented by the inheriting class
	pass

func _on_Powerup_area_entered(area: Area2D) -> void:
	if area is Player:
		applyPowerup(area)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
