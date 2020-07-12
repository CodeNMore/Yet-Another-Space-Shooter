extends Powerup

export var shieldTime := 5.0

func onCollect(player: Player):
	player.applyShield(shieldTime)
