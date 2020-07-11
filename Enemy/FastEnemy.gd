extends Enemy

export var rotationRate := 20

func _process(delta):
	rotate(deg2rad(rotationRate) * delta)
