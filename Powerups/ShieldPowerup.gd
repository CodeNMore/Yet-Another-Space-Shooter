extends Powerup

export var shieldTime: float = 6

func applyPowerup(player: Player):
	player.applyShield(shieldTime)
