extends Powerup

export var time := 2.5

func onCollect(player: Player):
	player.applyRapidFire(time)
