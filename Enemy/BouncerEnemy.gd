extends SlowShooter

export var horizontalSpeed := 50.0

var horizontalDirection: int = 1

func _physics_process(delta):
	position.x += horizontalSpeed * delta * horizontalDirection

	var viewRect := get_viewport_rect()
	if position.x < viewRect.position.x or position.x > viewRect.end.x:
		horizontalDirection *= -1
