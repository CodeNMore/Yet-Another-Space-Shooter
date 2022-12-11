extends Powerup

export var rapidFireTime: float = 4

func applyPowerup(player: Player):
	player.applyRapidFire(rapidFireTime)
