extends Enemy
class_name SlowShooter

onready var fireTimer := $FireTimer

export var fireRate := 1.0

func _process(delta):
	if fireTimer.is_stopped():
		fire()
		fireTimer.start(fireRate)
